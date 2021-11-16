import re
import sys
import xml.etree.ElementTree as ET
from datetime import datetime
from pathlib import Path
import numpy as np
import os, shutil


def parse_timestamp(stamp):
    return datetime.timestamp(datetime.strptime(stamp, "%Y-%m-%dT%H:%M:%SZ"))


def file_contains_fft_real(lines):
    return np.max([l.find("fft_real") > 0 for l in lines]) or np.max(
        [l.find("ifft_real") > 0 for l in lines]
    )


def is_jsfx(fn):
    return fn.endswith("jsfx") or fn.endswith("jsfx-inc")


def plugin_contains_fft_real(name, files):
    for fn in files:
        if is_jsfx(fn):
            fullpath = f"{name}/{fn}"
            if not os.path.isfile(fullpath):
                print(f"Plugin {fn} found in index file is missing from path.")
                return False
            with open(fullpath, "r", encoding="UTF-8") as f_in:
                if file_contains_fft_real(f_in.readlines()):
                    return True


def find_plugins_that_need_compatibility_mode(
    index_file="index.xml",
    verbose=False,
    exclude_list=["SpectrumAnalyzer", "reajs_compatibility"],
):
    if verbose:
        print("Populating plugin list")
    compat_plugins = []
    root = ET.parse(index_file).getroot()
    for group in root:
        name = group.get("name")
        if name not in exclude_list:
            for plugin in group:
                last_version = plugin[-1]
                if verbose:
                    print(
                        f"  Processing {name}/{plugin.get('name')} ({last_version.get('name')})'"
                    )

                files = [k.attrib["file"] for k in last_version if "file" in k.attrib]
                files.append(plugin.get("name"))

                if plugin_contains_fft_real(name, files):
                    # This is one needs a specialized version.
                    current_compat_plugins = [fn for fn in files if fn.endswith("jsfx")]
                    presets = [fn for fn in files if fn.endswith("rpl")]
                    # We also need to make sure that the directories exist.
                    dirs = s = set(str(Path(f).parent) for f in files)
                    dirs.discard(".")
                    compat_plugins.append(
                        {
                            "name": name,
                            "fns": current_compat_plugins,
                            "dirs": dirs,
                            "presets": presets,
                        }
                    )

    return compat_plugins


def append_suffix(fn, suffix):
    l = fn.split(".")
    assert len(l) > 1
    l[0] += suffix
    return ".".join(l)


def process_file(name, fn, compat_dir):
    os.makedirs(f"{outdir}/", exist_ok=True)

    # Words before which to import the compatibility library. Note that we
    # need this to be the first library to be imported, otherwise it will not work.
    writing = True
    with open(f"{name}/{fn}", "r", encoding="UTF-8") as f_in, open(
        f"{outdir}/{append_suffix(fn, '_compat')}", "w", encoding="UTF-8"
    ) as f_out:
        f_out.write("import reajs_compatibility.jsfx-inc\n")
        f_out.write("noindex: true")
        for line in f_in.readlines():
            if line.find("desc:") > -1:
                f_out.write(f"{line.strip()} [ReaJS-Compatibility]\n")
            else:
                if not writing and line.find(":") > -1:
                    writing = True

                if line.find("provides") > -1:
                    writing = False

                if writing:
                    f_out.write(line)


def determine_version(plugin_list_file):
    if not os.path.isfile(plugin_list_file):
        return "0.001"
    else:
        with open(plugin_list_file, "r", encoding="UTF-8") as f_in:
            version = (
                int(re.match("version: (\d+).(\d+)", f_in.readlines()[2]).groups()[1])
                + 1
            )
            return f"0.{version:03d}"


def generate_compat_file(outdir, compat_plugs, compat_file):
    os.makedirs(f"{outdir}/", exist_ok=True)
    for f in compat_plugs:
        for d in f["dirs"]:
            os.makedirs(f"{outdir}/{d}", exist_ok=True)
        for fn in f["fns"]:
            process_file(f["name"], fn, outdir)
        for fn in f["presets"]:
            shutil.copyfile(
                f"{f['name']}/{fn}", f"{outdir}/{append_suffix(fn, '_compat')}"
            )

    plugin_list_file = f"{outdir}/saike_plugins_reajs.jsfx"
    version = determine_version(plugin_list_file)
    print(f"Updating to version {version}")

    with open(f"{outdir}/{compat_file}", "w", encoding="UTF-8") as f_out:
        f_out.write(
            f"""
desc:ReaJS compatibility description
version: 0.01
author: Joep Vanlier
changelog: 
about: 
ReaJS Compatibility File.
-------------------------

This file emulates fft_real. However, considering that normally fft_real needs half the 
space to operate, there is a catch. You need twice the memory to work with. You need to make 
sure that you leave an fft sized block empty between where you'd normally use fft_real and ifft_real.

Copyright (C) 2021 Joep Vanlier
License: MIT

@init
reaJS_compatibility_mode = 1;

function fft_real(fftLoc, N)
  local(ptr_slow, ptr_fast)
  global()
  instance()
  (
    // Restride with empty imaginary component
    ptr_slow = fftLoc + N - 1;
    ptr_fast = fftLoc + 2 * N - 2;
    loop(N,
      ptr_fast[] = 2 * ptr_slow[];
      ptr_fast[1] = 0;
      ptr_fast -= 2;
      ptr_slow -= 1;
    );
    
    // Normal FFT.
    fft(fftLoc, N);
    fft_permute(fftLoc, N);
    
    // Convert to what you'd expect the output of fft_real to be.
    fft_ipermute(fftLoc, N / 2);
  );

function ifft_real(fftLoc, N)
  local(ptr_slow, ptr_fast)
  global()
  instance()
  (
    // Undo the fftreal permutation.
    fft_permute(fftLoc, N / 2);
 
    // Reassemble the full spectrum taking into account the symmetry 
    // one would expect from a real spectrum. Re[f(w)] = Re[f(-w)] and Im[f(w)] = -Im[f(-w)]
    ptr_slow = fftLoc + 2;
    ptr_fast = fftLoc + 2 * N - 2;
    loop(N / 2,
      ptr_fast[] = ptr_slow[];
      ptr_fast[1] = - ptr_slow[1];
      ptr_fast -= 2;
      ptr_slow += 2;
    );
    
    fft_ipermute(fftLoc, N);
    ifft(fftLoc, N);
    
    // fft produces real and imaginary result. Just drop the imaginary result.
    ptr_slow = fftLoc;
    ptr_fast = fftLoc;
    loop(N,
      ptr_slow[] = ptr_fast[];
      ptr_fast += 2;
      ptr_slow += 1;
    );
  );     
            """
        )

    plugin_list = []
    for plug in compat_plugs:
        for f in plug["fns"]:
            plugin_list.append(f"  {append_suffix(f, '_compat')}")

    for plug in compat_plugs:
        for f in plug["presets"]:
            plugin_list.append(f"  {append_suffix(f, '_compat')}")

    with open(plugin_list_file, "w", encoding="UTF-8") as f_out:
        nl = f"\n"
        f_out.write(
            f"""desc:ReaJS Compatibility Pack
tags: compatibility
version: {version}
author: Joep Vanlier
changelog: First release
provides:
  {compat_file}
{f'{nl}'.join(plugin_list)}
about:
    # ReaJS Compatibility Pack
    Considering ReaJS hasn't been updated in a while, it is missing some of the latest functionalities that JSFX supports.
    This small pack contains some versions with workarounds that make them compatible with ReaJS. Note that for a plugin 
    to work in ReaJS, you need to install both this entire pack and the plugins you wish to use (it uses dependencies from
    those plugins).

    license: MIT
"""
        )


if __name__ == "__main__":
    index_file = sys.argv[1] if len(sys.argv) > 1 else "index.xml"
    print("Indexing from: " + index_file)
    compat_plugs = find_plugins_that_need_compatibility_mode(index_file)
    outdir = "reajs_compatibility"
    compat_file = "reajs_compatibility.jsfx-inc"
    os.makedirs(outdir, exist_ok=True)
    generate_compat_file(outdir, compat_plugs, compat_file)
