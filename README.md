# JSFX

This is a small bundle of JSFX and scripts for reaper.
 You can install 
these by adding the link:

https://raw.githubusercontent.com/JoepVanlier/JSFX/master/index.xml

to your reapack (https://reapack.com/) list of repositories. If you run 
into issues with these, feel free to open an issue here on github.

# Multi-channel spectral analyser with sonogram and time window
I needed a plugin that I could keep open on one screen to monitor things.
Hence I modified the stock Reaper spectral analyzer to allow for 
multi-channel analysis and combine it with a sonogram and time window.

![Spectral Analyzer](https://i.imgur.com/BkDa0S5.png)

The JSFX comes with a lua script which sets up the routing appropriately
on a new FX track.

### White/Black

Chooses background color.


### Smoothing

Chooses size of spectral smoothing. Spectral smoothing is performed in 
the frequency domain, 
  using larger smoothing for higher values. Note 
that this is not an unbiased smoother.
  More smoothing means that peaks 
get wider and the spectrum becomes less accurate.  The noise 
is also 
suppressed however, which makes it easier to read when there are multiple 
spectra.


### Color map

Specifies colormap for spectral analyzer.


### Scale

Scale indicators the zoom factor on the spectrum analyzer.

  
### Integrate

Integrate spectrum over time. This makes the spectrum less noisy, but 
less sensitive to short transients. Smoothness is a tradeoff between 
smoothing (width), integration time (transients) 
and noise (no smoothing 
or integration time).


### Floor

Specify where to put the noise floor.


### Window

Window function. Defaults to Blackman-Harris for its resolution.


### FFT

FFT window size. 8192 is pretty good. Higher is heavier on the CPU.


### Log(Sonogram)

Enabling this shows the sonogram with a logarithmic frequency axis. 
Disabling it means linear.


### Sonogram/Time toggle

Determine whether you want to see the waveform or the sonogram. 
Waveform is good for studying 
transients. Sonogram is good for 
studying frequencies over time.



## Channel buttons

The next buttons indicate what channels are visualized. Enabling 
or disabling them can be done 
  by clicking them with the left 
mouse button. Clicking them with the right mouse button will make 

them the active channel in the sonogram or time window. This way,
you can study the sonograms of  the channels separately.


### Sum

Indicates the sum of the signal. This will show the left and right 
channel in black and grey in the main graph. Enabling or disabling 
can be done by left clicking. Clicking this with the outer mouse 
button will show the signal in the sonogram or time window.


### Ch1 - Ch16

The channels that are routed to the spectral analyser. Enabling or 
disabling can be done by left 
  clicking. Clicking this with the outer 
mouse button will show the signal in the sonogram or time 
window.



## Sonogram mode
Double-clicking the sonogram will toggle its size. Clicking and 
dragging with the left mouse button 
will change how bright it is. 
Clicking with the right mouse button will switch colormap. The channel 

you're viewing and the scale are shown on the top left. The colormap 
on the bottom left. Switch with outer mouse button on the channel 
button in the second row on the top. Mousewheel will change the 
scaling 
w.r.t. the frequency axis. Doubleclicking alters the sonogram size.

## Time mode
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