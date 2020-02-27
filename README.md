# JSFX

This is a small bundle of JSFX and scripts for reaper.
 You can install 
these by adding the link:

https://raw.githubusercontent.com/JoepVanlier/JSFX/master/index.xml

to your reapack (https://reapack.com/) list of repositories. If you run 
into issues with these, feel free to open an issue here on github.

# Swellotron
![SwellotronUI](https://i.imgur.com/ikizwwk.gif)

It computes the spectrum of both signals (using the STFT), multiplies the magnitudes in the spectral domain and puts the result of that in an energy buffer. This energy buffer is drained proportionally to its contents. The energy buffer is then used to resynthesize the sound, but this time with a random phase.

In plain terms, it behaves almost like a reverb, where frequencies that both sounds have in common are emphasized and frequencies where the sounds differ are attenuated. This will almost always lead to something that sounds pretty harmonic.

Features:
- Shimmer: Copies energy to twice the frequency (leading to iterative octave doubling).
- Aether: Same as shimmer but for fifths.
- Scorch: Input saturation.
- Ruin: Output saturation.
- Diffusion: Spectral blur.
- Ice: Chops small bandwidth bits from the energy at random, and copies them to a higher frequency (at 1x or 2x the frequency), thereby giving narrowband high frequency sounds (sounding very cold).

# SatanVerb
![SatanUI](https://i.imgur.com/JLXFrOH.png)

Satan verb is a reverberation unit mostly meant for diffuse and gated style reverberation. It can either be used without an envelope, to generate large ambient spaces, or be modulated by an envelope based on the input sound to give a sound more body while not adding too much noise to the dead time.

Features
- FFT based reverberation algorithm.
- Optional downward spectral smearing for creepy effects.
- Optional spectrally shifted copy can be mixed in.
- Steep IIR LPF/HPF filters for the verb.
- Optional delay compensation.
- Envelopes based on the input envelope.
- Input non-linearity (dist), spectrum non-linearity (ceiling).
- Dry/Wet controls.

# Squashman
Squashman is a multi-band saturation / distortion plugin that allows modulation of several of its parameters.

Features:
- Optional high quality oversampling
- Flexible band count, up to five bands can be used to manipulate sound
- 24 db/oct Linkwitz Riley crossover filters
- Graphical user interface
- 25 modulatable waveshapers and 4 fixed ones.
- Several modulation sources (4 LFOs, 2 MIDI triggered and/or loopable envelopes).

![SquashmanUI](https://imgur.com/DPEquCN.png)

![Shapers](https://imgur.com/X8Y18k2.png)

A short demo here:
https://www.youtube.com/watch?v=mK0xAhq4pK4

# Filther
![Filther](https://i.imgur.com/oCkDyyz.png)

Filther is a waveshaping / filterbank plugin that allows for some dynamic processing as well.

**Manual** for Filther here: https://joepvanlier.github.io/FiltherManual/

#### What does it sound like?
All the distortion/filtering on that track was done with this filter (mostly nonlin Kr0g and Rezzy):
https://soundcloud.com/saike/ohnoesitsaboss2/s-zYCOt

It can also sound pretty destructive:
https://soundcloud.com/saike/sine/s-mbHJL
https://soundcloud.com/saike/fm-modes-filther/s-KXwEQ

Youtube tutorial: https://www.youtube.com/watch?v=jtc8kp57xpI

For more information, or to contact the author, see the forum thread here: https://forum.cockos.com/showthread.php?t=213269

#### Features
- Spline waveshaping curve based on placing nodes. Can draw asymmetric curves as well.
- Two non-linear filter modules which can be automated by dynamics from the input signal or a side chain, LFO or envelopes.
- Waveshaping amount can be modulated by input dynamics, LFOs or envelopes.
- Modulators can optionally be triggered by MIDI notes.
- Large number of filter types (linear filters, analog models, FM, AM filters, reverbs, distortions).
- Feedback section.
- Automatic Gain Control to protect your ears somewhat.

![Filtertypes](https://i.imgur.com/mmfv1rk.png)

# Tight Compressor
![TightCompressor](https://i.imgur.com/0rES8lF.jpg)

This peak compressor is based on a paper by Giannoulis et al, "Digital Dynamic Range Compressor Design—A Tutorial and Analysis", Journal of the Audio Engineering Society 60(6). It seems to be a pretty decent at tight style compression, with pretty aggressive attack. The compression is continuously visualized to help you dial in the appropriate settings.

# Stereo Bub II
![StereoBub](https://i.imgur.com/a09HF51.jpg)

A fairly basic stereo widening tool. Widens the sound, but makes sure that the mono-mix stays unaffected (unlike Haas). The crossover is basically a 12 pole HPF that cuts the bass of the widening to avoid widening the bass too much. The last slider allows you to mix in the original side channel (which can optionally also be run through the 12-pole highpass).

There are two basic modes of operation:
1. You can either add stereo sound from nothing, using the Strength slider. This adds a comb filtered version of the average signal with opposite polarity to the different channels. Be careful not to overdo it, or you get a flangey sound (unless that is what you want).
2. You can manipulate the existing side channel that's in the input. The gain of the original side channel is scaled by the old "Old side" knob. Depending on the button "HP original side" this signal route will be highpassed (mono-izing the low frequencies).

# Stereo Bub III
![StereoBub3](https://i.imgur.com/1JQFa5w.png)
It's pretty much the same as II, except it adds vibrato on left and right and a squash option to box in the side channel. This squash option can be useful at times to mask the phasing effects you can sometimes hear on drums. Mind you, too much of it will cause harmonics that will completely vanish when mixing down to mono, so be careful with that one.


# Transience
![TransienceUI](https://imgur.com/TgC7n2B.png)

Transience is a plugin for enhancing or reducing transients. It works by using two envelopes. One is an envelope follower (short attack, longer decay; roughly follows the peaks of the sound), the other is a user specified envelope (with attack/decay). You can then shape the sound according to the difference between the two, making attacks or decays longer or shorter. The plugin operates in logarithmic space.

# Tone Stacks
![ToneStacksUI](https://imgur.com/giyF29j.jpg)

Tone Stacks emulates the tone stacks of some classic guitar amps. It is based on the work of jatalahd and ~arph from diystompboxes.com forum. See their visualization tool here: http://www.guitarscience.net/tsc/info.htm 
Tone stacks contains some bi-linearly transformed versions of these filters.

# Bandsplitter/joiner
![BandSplitterUI](https://imgur.com/nOhiaJB.png)

4-pole band splitter that preserves phase between the bands. It has a UI and uses much steeper crossover filters (24 dB/oct) than the default that ships with reaper thereby providing sharper band transitions.

It also has an option for linear phase FIR crossovers instead of the default IIR filters. IIRs cost less CPU and introduce no preringing or latency. The linear phase FIRs however prevent phase distortion (which can be important in some mixing settings), but introduce latency compensation. Note that when using the linear phase filters, it is not recommended to modulate the crossover frequencies as this introduces crackles.

# ReflectoSaurus
![Reflectosaurus](https://imgur.com/aEhOMVo.png)
Tool for making creative delays and reverbs. Each node indicates a delay. X axis controls the delay time, Y axis controls the volume, while the radius indicates how much feedback the delay has. Each delay node contains a lowpass and highpass filter. The arc indicates which frequency range of the sound is allowed to pass each feedback round. The little knob indicates the panning of the node.

Nodes can be routed to each-other to create complex effects. Routing sends are sent out before applying the feedback gain, but after the filters. The arc around the routing arrow indicates the volume at which it is being sent to the other node.

Delays/Grid can optionally be synchronized to host tempo on 3/4, 4/4 or 5/4 rhythm. Reflectosaurus also sports one special FFT reverb node, which is indicated in red. Remember to mute all unused nodes as this lowers CPU significantly.

![InfographicReflectoSaurus](https://i.imgur.com/a4ISztr.png)

Examples of possibilities:

https://instaud.io/3SRO

https://instaud.io/3SZq

https://www.youtube.com/watch?v=bGgYUSdWiAA

https://www.youtube.com/watch?v=PJKxva-5x54

# Amaranth
![AmaranthUI](https://i.imgur.com/CfZ9oLm.png)

Graintable tool. Wouldn't recommend using this one for any serious project yet, and if you do, make sure you render out your results, as I may still make changes that break backward compatibility 

# Multi-channel spectral analyser with sonogram and time window
I needed a plugin that I could keep open on one screen to monitor things.
Hence I modified the stock Reaper spectral analyzer to allow for 
multi-channel analysis and combine it with a sonogram and time window.

![Spectral Analyzer](https://i.imgur.com/CRpRL00.png)

The JSFX comes with a lua script which sets up the routing appropriately
on a new FX track.

#### White/Black

Chooses background color.


#### Smoothing

Chooses size of spectral smoothing. Spectral smoothing is performed in 
the frequency domain, 
  using larger smoothing for higher values. Note 
that this is not an unbiased smoother.
  More smoothing means that peaks 
get wider and the spectrum becomes less accurate.  The noise 
is also 
suppressed however, which makes it easier to read when there are multiple 
spectra.


#### Color map

Specifies colormap for spectral analyzer.


#### Scale

Scale indicators the zoom factor on the spectrum analyzer.

  
#### Integrate

Integrate spectrum over time. This makes the spectrum less noisy, but 
less sensitive to short transients. Smoothness is a tradeoff between 
smoothing (width), integration time (transients) 
and noise (no smoothing 
or integration time).


#### Floor

Specify where to put the noise floor.


#### Window

Window function. Defaults to Blackman-Harris for its resolution.


#### FFT

FFT window size. 8192 is pretty good. Higher is heavier on the CPU.


#### Log(Sonogram)

Enabling this shows the sonogram with a logarithmic frequency axis. 
Disabling it means linear.


#### Sonogram/Time toggle

Determine whether you want to see the waveform or the sonogram. 
Waveform is good for studying 
transients. Sonogram is good for 
studying frequencies over time.



### Channel buttons

The next buttons indicate what channels are visualized. Enabling 
or disabling them can be done 
  by clicking them with the left 
mouse button. Clicking them with the right mouse button will make 
them the active channel in the sonogram or time window. This way,
you can study the sonograms of  the channels separately.


#### Sum

Indicates the sum of the signal. This will show the left and right 
channel in black and grey in the main graph. Enabling or disabling 
can be done by left clicking. Clicking this with the outer mouse 
button will show the signal in the sonogram or time window.


#### Ch1 - Ch16

The channels that are routed to the spectral analyser. Enabling or 
disabling can be done by left 
  clicking. Clicking this with the outer 
mouse button will show the signal in the sonogram or time 
window.



### Sonogram mode
Double-clicking the sonogram will toggle its size. Clicking and 
dragging with the left mouse button 
will change how bright it is. 
Clicking with the right mouse button will switch colormap. The channel 
you're viewing and the scale are shown on the top left. The colormap 
on the bottom left. Switch with outer mouse button on the channel 
button in the second row on the top. Mousewheel will change the 
scaling 
w.r.t. the frequency axis. Doubleclicking alters the sonogram size.

### Time mode
Clicking and dragging or using the mouse wheel  will change the scale 
of the graph. The channel you're 
viewing is shown on the top left. Switch 
with outer mouse button on the channel button in the second row on the top. 
Doubleclicking alters the signal window size.

# SideSpectrum Meter
A stereo spectral analyzer to study how much the left and right channel 
differ.

# StereoManipulator
A stereo width manipulator with a large number of filters. 

Splits the channel into two via crossover filter. Both channels can then 
be mono-ified separately. Use FIR filter for strong transients, but note 
that this incurs N/2 delay of the signal. Larger filters are required for 
cutting lower freq. Larger filters will also reduce aliasing. Use high 
order IIR for less transient heavy stuff. This incurs no global delay 
but may alter transients. FIRs are much more expensive than IIRs.

If you hear phase cancellation, set use channel to left or right rather 
than mix. Note that widths other than 0 or 100\% in this setting is not
recommended since this will create volume differences between left and right.
