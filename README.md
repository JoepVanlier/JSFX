# JSFX

This is a small bundle of JSFX and scripts for reaper.
 You can install 
these by adding the link:

https://raw.githubusercontent.com/JoepVanlier/JSFX/master/index.xml

to your reapack (https://reapack.com/) list of repositories. If you run 
into issues with these, feel free to open an issue here on github.

# Filther, a waveshaping filter / distortion plugin with dynamic processing.
![Filther](https://i.imgur.com/8ofYcFE.png)

Filther is a waveshaping / filter plugin that allows for some dynamic processing as well.

#### What does it sound like?
All the distortion/filtering on that track was done with this filter (mostly nonlin Kr0g and Rezzy):
https://soundcloud.com/saike/ohnoesitsaboss2/s-zYCOt

It can also sound pretty destructive:
https://soundcloud.com/saike/sine/s-mbHJL
https://soundcloud.com/saike/fm-modes-filther/s-KXwEQ

The more experimental filters (such as "Experimental" and "Phase Mangler") can be used on pads to make eerie soundscapes: https://soundcloud.com/saike/filter-ambience/s-UxdLO

Here's a short tutorial on how to use it: https://www.youtube.com/watch?v=jtc8kp57xpI

Older tutorial: https://www.youtube.com/watch?v=YlgsVy-C2yI

(You can also find the spectral analyzer in the repo).

For more information, or to contact the author, see the forum thread here: https://forum.cockos.com/showthread.php?t=213269

### Waveshaping
Filther supports saturating soft clipping as well as drawing custom voltage curves using a spline. For the simpler filters, the distortion is simply applied before the filtering stage, but for some the filter is located in the filter scheme. In these cases, the distortion is either applied on the delayed or during solving the implicit equations for the supplied zero delay feedback filters (ZDF).

Waveshaping introduces higher harmonics and can cause aliasing (frequencies above Nyquist that wrap back into the spectrum and cause inharmonic artefacts). To mitigate this, filther allows oversampling. Note that oversampling incurs more CPU cost though. Some of the filters in filther require a minimal amount of oversampling for stability. Both FIR and IIR _upsampling/downsampling_ are provided (to prevent aliasing when distorting). FIR filtering does less damage to transients than IIR, but is more costly.

### Filters
Filther contains _two filter modules_ which can be automated by dynamics and LFO. The routing of the A and B filter can be altered (serial, parallel modes, plus control over the number of times the waveshaper is applied), 

Filther contains a large variety of filters, each with their own advantages and drawbacks. Most of the filters behave non-ideal and are intended for creative purposes rather than fidelity to specification. Note that not all filters are stable for all combinations of resonance and waveshaping. Using very sharp transitions in the spline waveshaper can result in filter instability for the filters where waveshaping is part of the filter. Filther contains a large array of filters listed below:

![Filtertypes](https://i.imgur.com/3L1S8T2.png)

### Special filter modes
Filter A has some special filter modes which can be used for stereo widening or processing samples differently.

### Feedback section
There is an additional feedback section, which can be activated.  Feedback can be used to fatten up filters and in some cases regain control of the resonance. If you want some fatness/resonance fighting, _keep the delay firmly placed at zero_. The feedback delay chain has the exact opposite polarity of the resonance in most chains, so in this mode, it will fight with the resonance to sort of choke in on itself (see diode ladder or ms-20 for this effect). This can make the resonance less ringey, more chunky and a lot more pleasant to listen to. Note that the global feedback is not ZDF. Also note that using feedback, reduces the maximum number of spline nodes by two.

For phasey effects, use feedback with larger delays. Note however that then you're in the danger zone, because once resonance starts boosting resonance, things get real dicey. I would always recommend playing with this only if you have AGC on.

### Automatic Gain Control
When tweaking, enable Automatic Gain Control to protect your ears from resonance issues. This rescales the volume so that the RMS value post filter is the same as the input level (meaning that you can leave the post fader at 0 dB). You can transfer the estimated gain to the post-gain fader with the outer mouse once you've honed in on a preset you like.

### Dynamics
Filther also supports dynamically modifying the filter and waveshaping settings, by checking "Filter" and/or "Shaping" in the Dynamics section. Dynamics can be monitored in the dynamics window. Here you will see the input RMS (red curve), output RMS (blue curve), dynamic variable and threshold (click and drag to zoom). The dynamic variable (yellow curve) will start accumulating when the input RMS is above the threshold. The threshold can be dragged with the mouse or set in the dynamics panel. Averaging can be increased by modifying the RMS time. This will smoothen out the RMS values that you see (and the dynamics will respond accordingly). Alternatively, dynamics can be triggered by MIDI note events. 

#### Waveshaping Dynamics
For waveshaping, Filther will interpolate between the non-waveshaped and waveshaped voltage response (1 being the fully waveshaped version). 

#### Filter Dynamics
The extent of modulation on the filter can be set with the outer mouse button. This will showed a greyed area that will show the extent of the dynamics being applied. When the dynamics are at maximum, the parameter value will be at the full extent of this greyed area.

#### A few notes/tips/warnings:
- _When tweaking, enable Automatic Gain Control to protect your ears from resonance issues. This rescales the volume so that the RMS value post filter is the same as the input level (meaning that you can leave the post fader at 0 dB). You can transfer the estimated gain to the post-gain fader with the outer mouse_.
- Play with the Pre-Gain / Drive. It can make a huge difference for both the filters and the waveshaper.
- Some filters such as the MS-20 (my fav), Rezzy and CEM/SSM saturate quite nicely when driven. These can be used without wave-shaper to get a cleaner distortion.
- Not all filters are unconditionally stable, so that means that some can bite your head of and end in a sad click. Most are though. 
- Some originate from music fora (Diode ladder, Karlsen ladder), others I implemented from papers (Expensive Moog, the phasers), others I modeled after circuit boards or diagrams found online (Kr0g, SSM, CEM) and some I circuit bended into existence (Experimental, Rezzy, Phase Mangler).
- The filters, all IIRs are not meant to be clean, many of them saturate in non-linear ways and add a lot of color to your sounds.
- The routing on each filter is different. For some the waveshaper is inside the filter feedback, for others it is a pre or post processing step. Deciding where to put the waveshaper was done subjectively.
- The nonlinear filters are more expensive since they solve a nonlinear system of equations at every sample. For all of the nonlinear filters I have also implemented a linearized variant and if you don't use the filter in its saturation range, it is better to use the linear variants for performance reasons.
- ZDF in the filter name stands for Zero Delay Feedback, which means that there is no extra delay present in the feedback loop.
- Spline waveshaping is significantly more expensive than atanh or fast waveshaping. It can also cause instability in some filters where the spline is in the feedback loop. Yet, because a lot of sonic sweetspots exist that make use of this, I have decided to still expose the ability to do this. Tread lightly.
- Have fun with dynamics. Motion makes everything better.
- Feedback can be used to fatten up filters and in some cases regain control of the resonance. If you want some fatness/resonance fighting, _keep the delay firmly placed at zero_. The feedback delay chain has the exact opposite polarity of the resonance in most chains, so in this mode, it will fight with the resonance to sort of choke in on itself (see diode ladder or ms-20 for this effect). This can make the resonance less ringey, more chunky and a lot more pleasant to listen to. Note that the global feedback is not ZDF. Also note that using feedback, reduces the maximum number of spline nodes by two.
- For phasey effects, use feedback with larger delays. Note however that then you're in the danger zone, because once resonance starts boosting resonance, things get real dicey. I would always recommend playing with this only if you have AGC on.
- Morph mode (under routing) allows you to interpolate between filter A and B. Note however, that morph mode eats one node of the spline.

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
