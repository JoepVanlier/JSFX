# JSFX

This is a bundle of JSFX and scripts for reaper.

# Installation instructions

The easiest way to use these, is to use Reapack.

#### Step 1: Install Reapack

To do this, please follow the installation instructions here: https://reapack.com/user-guide#installation

#### Step 2: Add this repository to Reapack

The next step is to add the following repository to your reapack: https://raw.githubusercontent.com/JoepVanlier/JSFX/master/index.xml

![addrepo](https://user-images.githubusercontent.com/19836026/110243225-c0e54580-7f59-11eb-9ac8-a656b4f45b6f.png)

#### Step 3: Find and install the plugin you want.

Now it's just a matter of checking out what's on offer and installing those that you want. No worries, it's all free stuff.

 ![findplugin](https://user-images.githubusercontent.com/19836026/110243353-48cb4f80-7f5a-11eb-8126-0805a0a223af.png)

#### Step 4: Refresh your FX list (or restart Reaper) and find the plugin.

The plugins won't show up until you refresh your FX list or restart reaper.

#### Step 5: Enjoy! :)

Note that everything is permissively licensed, but if you use some of the code in your own works, I'd appreciate a mention. Thanks!

## What if I want to use the plugins in another DAW?

If you're on Windows, you can use ReaJS: https://www.reaper.fm/reaplugs/
Note however, that while some plugins will just work, for others you have to install their ReaJS compatibility version.
Look in the repo for reajs_compatibility. These plugins generally end in `_compat`. Note that they require the regular plugin to be installed as well, since they use the same dependencies.

# The assortment

## Yutani - Bass synth
![lights](https://user-images.githubusercontent.com/19836026/110242823-0739a500-7f58-11eb-9473-8cd214746b13.gif)

Monophonic/4-voice paraphonic bass synthesizer with some fancy filters and modulation options.

Note: Remember to import the bass presets when you download this thing.

Features:
- Anti-aliased oscillators.
- 14 Filters of which 9 non-linear analog modelled ones, all with their own unique tone. Try driving them!
- Audio-rate modulation options on the filter.
- Velocity, modulation wheel and LFO modulation options.
- Stereo widening effect.
- Noise.
- Distortion module.
- Glide.
- Modwheel, MIDI velocity and pitch bend support.

Demo here: https://www.youtube.com/watch?v=rBJ94Ye_az8

Demo with the paraphonic mode here (Yutani > Ravager > Reflectosaurus): https://raw.githubusercontent.com/JoepVanlier/Audio_Demos/main/Yutani/imd_dirt2.mp3

Non-linear filter demo (nlSVF): https://raw.githubusercontent.com/JoepVanlier/Audio_Demos/main/Yutani/nlSVF3.mp3

Non-linear filter demo (nlSVF): https://raw.githubusercontent.com/JoepVanlier/Audio_Demos/main/Yutani/nlSVF.mp3

Non-linear filter demo (Steiner): https://raw.githubusercontent.com/JoepVanlier/Audio_Demos/main/Yutani/mean_steiner.mp3

Non-linear filter demo (Steiner asym): https://raw.githubusercontent.com/JoepVanlier/Audio_Demos/main/Yutani/more_controlled.mp3

## FM Filter 2
![lights_fmfilter](https://user-images.githubusercontent.com/19836026/110242715-998d7900-7f57-11eb-8c6e-48b825b8f47e.gif)

For those days when you want to have access to Yutani's non-linear filters, but want to use an audio source.

Features:
- 15 filters, from well behaved linear models, to gnarly analog modelled nastiness.
- Audio and MIDI controllable filters.
- Audio and MIDI controllable gate.
- Three LFOs.
- Modwheel and MIDI velocity support.
- Stereo widening effect.
- Distortion module.

## Bric-a-brac - Texture machine

Bric-a-brac is intended to add textures to existing sounds. It can for example be used to brighten up beats by loading a noise sample in a sample slot. Or add some organic textures by adding a creaking sound that plays before the attack of a synth.

![bric_a_brac](https://user-images.githubusercontent.com/19836026/126071183-81e95f48-9e15-45e0-890b-23fb3f48ae0b.gif)

Features:
- 4 sample slots that can be triggered or looped to add textures to existing sounds.
- For each sample choose whether it should act as envelope follower, thresholded or triggered envelopes.
- One LFO modulator per sample.
- A lowpass/highpass filter per sample that can be modulated by the envelope and/or an LFO modulator.
- Variable pre-delay per sample.

## SEQS - Effects Sequencer

SEQS: A small GUI-based effect sequencer for stutters, slowdowns and various audio effects.

![drag_drop](https://user-images.githubusercontent.com/19836026/115153701-a2ee2300-a077-11eb-86bc-8eab6f13450d.gif)

![modulators_new](https://user-images.githubusercontent.com/19836026/115153706-a681aa00-a077-11eb-8105-ec78bf7133e1.gif)

Features:
- Choose from 14 effects, with lots of parameters inside each effect.
- Modulate all of the effect parameters by linking them up to the two macro modulator controls.
- Drag and drop to reorder the effects that do not control the playhead.
- Synchronize the patterns to the host, free or MIDI.
- See exactly what audio is coming in, right above the pattern, making it easier to place the blocks in the correct places.
- Build up to 64 patterns.
- Select pattern by incoming MIDI note.
- Choose to set times in the plugin by time or beats.
- Randomize tracks.
- Choose from a large number of effects:
  - Effects that modify the playhead: Slowdown, Tape stop, Retrigger, Reverse.
  - Chorus / Phaser / Flaser module.
  - Pitch shifter.
  - Degradation effects (sample rate and bitrate reduction).
  - Two non-linear envelope controlled multimode filters (choose from 15 filter types, with several non-linear ones).
  - Volume envelope.
  - Reverb.
  - Pitched Delay (delay with delaylength such that it produces tonal sounds).
  - Amplitude / Ring modulation module.
  - Tempo synchronized delay.

## Ravager - Extreme upwards compressor
![ravager_new_cut](https://user-images.githubusercontent.com/19836026/109434612-6d816d80-7a16-11eb-8bbc-f5fbaf97dd75.gif)

Destroys incoming audio by performing extreme upward compression.

Features:
- (Optional)Multi-band processing (add/remove with right mouse button).
- Extreme upward compression pulling up almost anything.
- Limiting in the forms of hard clipping / soft clipping.

Following demos are Yutani -> Reflectosaurus -> Ravager (no other effects)

Demo: https://raw.githubusercontent.com/JoepVanlier/Audio_Demos/main/Ravager/dry_wet.mp3

Demo: https://raw.githubusercontent.com/JoepVanlier/Audio_Demos/main/Ravager/multiband_version.mp3

Demo: https://raw.githubusercontent.com/JoepVanlier/Audio_Demos/main/Ravager/upwardcompress.mp3

## Swellotron - Soundscape effect
![SwellotronUI](https://i.imgur.com/ikizwwk.gif)

Machine for combining two sounds into ambient soundscapes.

It computes the spectrum of both signals (using the STFT), multiplies the magnitudes in the spectral domain and puts the result of that in an energy buffer. This energy buffer is drained proportionally to its contents. The energy buffer is then used to resynthesize the sound, but this time with a random phase.

In plain terms, it behaves almost like a reverb, where frequencies that both sounds have in common are emphasized and frequencies where the sounds differ are attenuated. This will almost always lead to something that sounds pretty harmonic.

Features:
- Shimmer: Copies energy to twice the frequency (leading to iterative octave doubling).
- Aether: Same as shimmer but for fifths.
- Scorch: Input saturation.
- Ruin: Output saturation.
- Diffusion: Spectral blur.
- Ice: Chops small bandwidth bits from the energy at random, and copies them to a higher frequency (at 1x or 2x the frequency), thereby giving narrowband high frequency sounds (sounding very cold).

## ReflectoSaurus - Soundscape effect
![reflectosaurus_new_cut](https://user-images.githubusercontent.com/19836026/109434641-93a70d80-7a16-11eb-8279-f1525c676de7.gif)

Tool for making creative delays and reverbs. Each node indicates a delay. X axis controls the delay time, Y axis controls the volume, while the radius indicates how much feedback the delay has. Each delay node contains a lowpass and highpass filter. The arc indicates which frequency range of the sound is allowed to pass each feedback round. The little knob indicates the panning of the node.

Nodes can be routed to each-other to create complex effects. Routing sends are sent out before applying the feedback gain, but after the filters. The arc around the routing arrow indicates the volume at which it is being sent to the other node.

Delays/Grid can optionally be synchronized to host tempo on 3/4, 4/4 or 5/4 rhythm. Reflectosaurus also sports one special FFT reverb node, which is indicated in red. Remember to mute all unused nodes as this lowers CPU significantly.

It looks complicated, but learning to use this machine will allow you to make quite some interesting spatial sounds.

Features
- Building complex chains of delays with negative and positive feedback.
- Tempo synchronization.
- Filters on every tap.
- Various modifiers that modify the delay on each tap (distortion, saturation, modulation and more).
- Granular resynthesis.
- Pitch shifting.
- FFT Reverb. Add this for lush sounds.
- Tuned mode to achieve Karplus-style string synthesis.

Examples of possibilities:

https://www.youtube.com/watch?v=47L9bysgIiA

https://www.youtube.com/watch?v=pUu3h21yARY

Full manual here: https://github.com/JoepVanlier/JSFX/raw/master/Reflectosaurus_Manual/Reflectosaurus_Manual.pdf

Demo of the Karplus style effects. Just Yutani and Reflectosaurus:

https://raw.githubusercontent.com/JoepVanlier/Audio_Demos/main/Reflectosaurus/karplus2.mp3

https://raw.githubusercontent.com/JoepVanlier/Audio_Demos/main/Reflectosaurus/karplus_test.mp3 (dry then wet)

## Nostalgizer - Lo-fi effect
![nostalgizer_cut](https://user-images.githubusercontent.com/19836026/109434617-72462180-7a16-11eb-8076-aa596ded1eae.gif)

Make your audio sound old with the nostalgizer.

A combination of a lowpass-gate and random detuning module.

Features
- Pitch instability.
- Low pass gate modelled after a famous unit.
- Adaptive saturation.
- Modelled noise as it is taken through a compander.

Demo: https://www.youtube.com/watch?v=Y8ibWk8Tpm0

## FM Filter - Filter
![FMFilter](https://imgur.com/iFOhQAd.png)

FM modulated filter. Good for making monophonic bass sounds chunkier. 

It has two main modes:

1. MIDI
In this mode it is mostly meant as a filter to put behind a bass synth. If you do, make sure you also send the MIDI signals to this filter as it has the ability to follow notes (adjusting the cutoff for each note) and it performs FM modulation based on the incoming pitch of the MIDI note. Basically, what it does is alternate the cutoff at audio rates (if FM level is bigger than 0). Also, the envelope is triggered by MIDI.

2. Audio
In this mode it's more for wreaking havoc. It can either modulate the cutoff frequency with its own signal (the self modes) or it can take a modulation signal from input 3/4 (either working in stereo 3/4 or mono 3+4).

Here's a small demo of the MIDI mode. First few seconds are dry, then wet. It can sound a bit talky:
https://soundcloud.com/saike/fm-filter-test/s-0uQ3xx0Xuln

Features:
- 2 linear, 4 non-linear filters.
- All filters are mode morph-able (morph between LP, BP, HP, BR, LP).
- Basic decay envelope.
- Audio rate cutoff modulation.
- Basic LFO modulation.

## SatanVerb - Pitching Reverb
![SatanUI](https://i.imgur.com/JLXFrOH.png)

Evil sounding reverb unit.

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

# Squashman - Multiband distortion
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

## Filther - Dynamic filtering effect
![Filther](https://i.imgur.com/oCkDyyz.png)

Filther is a distortion / effects unit which allows you to perform dynamic filtering and waveshaping.

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

Yet another compressor. This one is quite a tight little peak compressor.

This peak compressor is based on a paper by Giannoulis et al, "Digital Dynamic Range Compressor Design—A Tutorial and Analysis", Journal of the Audio Engineering Society 60(6). It seems to be a pretty decent at tight style compression, with pretty aggressive attack. The compression is continuously visualized to help you dial in the appropriate settings.

## Stereo Bub II - Mono compatible stereo widener
![StereoBub](https://i.imgur.com/a09HF51.jpg)

Stereo widener that preserves mono compatibility.

A fairly basic stereo widening tool. Widens the sound, but makes sure that the mono-mix stays unaffected (unlike Haas). The crossover is basically a 12 pole HPF that cuts the bass of the widening to avoid widening the bass too much. The last slider allows you to mix in the original side channel (which can optionally also be run through the 12-pole highpass).

There are two basic modes of operation:
1. You can either add stereo sound from nothing, using the Strength slider. This adds a comb filtered version of the average signal with opposite polarity to the different channels. Be careful not to overdo it, or you get a flangey sound (unless that is what you want).
2. You can manipulate the existing side channel that's in the input. The gain of the original side channel is scaled by the old "Old side" knob. Depending on the button "HP original side" this signal route will be highpassed (mono-izing the low frequencies).

## Stereo Bub III - Stereo widener
![StereoBub3](https://i.imgur.com/1JQFa5w.png)
It's pretty much the same as II, except it adds vibrato on left and right and a squash option to box in the side channel. This squash option can be useful at times to mask the phasing effects you can sometimes hear on drums. Mind you, too much of it will cause harmonics that will completely vanish when mixing down to mono, so be careful with that one.

## Transience - Transient modifier
![TransienceUI](https://imgur.com/TgC7n2B.png)

Transient shaper. Can modify attack and decay of incoming audio.

Transience is a plugin for enhancing or reducing transients. It works by using two envelopes. One is an envelope follower (short attack, longer decay; roughly follows the peaks of the sound), the other is a user specified envelope (with attack/decay). You can then shape the sound according to the difference between the two, making attacks or decays longer or shorter. The plugin operates in logarithmic space.

*Note: Transience relies on Tight Compressor being installed. If not, it will complain about missing my upsampling library.*

## Tone Stacks
![ToneStacksUI](https://imgur.com/giyF29j.jpg)

Tone Stacks emulates the tone stacks of some classic guitar amps. It is based on the work of jatalahd and ~arph from diystompboxes.com forum. See their visualization tool here: http://www.guitarscience.net/tsc/info.htm 
Tone stacks contains some bi-linearly transformed versions of these filters.

## Bandsplitter/joiner - Tool
![BandSplitterUI](https://imgur.com/nOhiaJB.png)

4-pole band splitter that preserves phase between the bands. It has a UI and uses much steeper crossover filters (24 dB/oct) than the default that ships with reaper thereby providing sharper band transitions.

It also has an option for linear phase FIR crossovers instead of the default IIR filters. IIRs cost less CPU and introduce no preringing or latency. The linear phase FIRs however prevent phase distortion (which can be important in some mixing settings), but introduce latency compensation. Note that when using the linear phase filters, it is not recommended to modulate the crossover frequencies as this introduces crackles.

## Amaranth - Granular Sampler
![AmaranthUI](https://i.imgur.com/CfZ9oLm.png)

Granular sampler.

## Multi-channel spectral analyser with sonogram and time window - Tool
I needed a plugin that I could keep open on one screen to monitor things.
Hence I modified the stock Reaper spectral analyzer to allow for 
multi-channel analysis and combine it with a sonogram and time window.

![Spectral Analyzer](https://imgur.com/DTEQ0am.jpg)

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
