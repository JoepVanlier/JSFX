--[[
@description Multi-channel spectral analyzer.
@author Joep Vanlier
@provides
  [main] .
@links 
  https://github.com/JoepVanlier/JSFX
@license MIT
@version 0.7
@about ### Multi-Channel Spectral Analyzer
  This script opens a JSFX multispectrum analyzer on a new FX track.
  It is basically an extensively modified version of the spectral analyzer shipped with 
  reaper. Calling the script will automatically route up to 16 channels to this FX and 
  open the spectral analysis window.
  
  ### White/Black
  Chooses background color.

  ### Smoothing
  Chooses size of spectral smoothing. Spectral smoothing is performed in the frequency domain, 
  using larger smoothing for higher values. Note that this is not an unbiased smoother.
  More smoothing means that peaks get wider and the spectrum becomes less accurate.  The noise 
  is also suppressed however, which makes it easier to read when there are multiple spectra.

  ### Color map
  Specifies colormap for spectral analyzer.

  ### Scale
  Scale indicators the zoom factor on the spectrum analyzer.

  ### Integrate
  Integrate spectrum over time. This makes the spectrum less noisy, but less sensitive to short 
  transients. Smoothness is a tradeoff between smoothing (width), integration time (transients) 
  and noise (no smoothing or integration time).

  ### Slope
  Modify the spectrum using a slope. -3 dB/oct will make pink noise seem flat.

  ### Floor
  Specify where to put the noise floor.

  ### Window
  Window function. Defaults to Blackman-Harris for its resolution.

  ### FFT
  FFT window size. 8192 is pretty good. Higher is heavier on the CPU.

  ### Log(Sonogram)
  Enabling this shows the sonogram with a logarithmic frequency axis. Disabling it means linear.

  ### Sonogram/Time toggle
  Determine whether you want to see the waveform or the sonogram. Waveform is good for studying 
  transients. Sonogram is good for studying frequencies over time.

  ## Channel buttons
  The next buttons indicate what channels are visualized. Enabling or disabling them can be done 
  by clicking them with the left mouse button. Clicking them with the right mouse button will make 
  them the active channel in the sonogram or time window. This way, you can study the sonograms of 
  the channels separately.

  ### Sum
  Indicates the sum of the signal. This will show the left and right channel in black and grey in 
  the main graph. Enabling or disabling can be done by left clicking. Clicking this with the outer
  mouse button will show the signal in the sonogram or time window.

  ### Ch1 - Ch16
  The channels that are routed to the spectral analyser. Enabling or disabling can be done by left 
  clicking. Clicking this with the outer mouse button will show the signal in the sonogram or time 
  window.

  ## Sonogram mode:
  Double-clicking the sonogram will toggle its size. Clicking and dragging with the left mouse button 
  will change how bright it is. Clicking with the right mouse button will switch colormap. The channel 
  you're viewing and the scale are shown on the top left. The colormap on the bottom left. Switch with 
  outer mouse button on the channel button in the second row on the top. Mousewheel will change the 
  scaling w.r.t. the frequency axis. Doubleclicking alters the sonogram size.
  
  ## Time mode:
  Clicking and dragging or using the mouse wheel  will change the scale of the graph. The channel you're 
  viewing is shown on the top left. Switch with outer mouse button on the channel button in the second 
  row on the top. Doubleclicking alters the signal window size.
--]]
--[[
 * Changelog:
 * v0.7 (2018-05-11)
   + Made the new one default
 * v0.6 (2018-05-10)
   + Added slope option
 * v0.5 (2018-05-10)
   + Fix bug with channel assignment 
 * v0.4 (2018-05-10)
   + Added colors to identify channels 
 * v0.3 (2018-05-10)
   + Added transparency setting
   + Added "OFF" option for sonogram/time window
   + Added solo (doubleclick on a channel)
   + Do not recreate spectrum track when it already exists, but merely add/remove channels
   + Only add top level channels to avoid adding channels multiple times
]]--

local function print(...)
  if ( not ... ) then
    reaper.ShowConsoleMsg("nil value\n")
    return
  end
  reaper.ShowConsoleMsg(...)
  reaper.ShowConsoleMsg("\n")
end

specname = "_SPECTRO_"
local function Main()
  reaper.Undo_BeginBlock()
  local project = 0
  local tracks = reaper.CountTracks(project)

  local spectroTrack
  local exists = 0
  local oldParams

  -- Kill a spectro channel if it already exists
  for i=0,tracks-1 do
    local track   = reaper.GetTrack(project, i)    
    local ret, name = reaper.GetTrackName(track, "                                                              ")
    
    if ( name == specname ) then
      -- Fetch the old spectro settings if there's already one here
      local count = reaper.TrackFX_GetNumParams(track, 0);
      spectroTrack = track
      exists = 1
    end
  end
  
  -- Create track at the end
  if ( not spectroTrack ) then
    reaper.InsertTrackAtIndex(tracks, true)
    spectroTrack = reaper.GetTrack(project, tracks)
  else
    -- Remove existing track sends
    for i=reaper.GetTrackNumSends(spectroTrack, -1)-1, 0, -1 do
      reaper.RemoveTrackSend(spectroTrack, -1, i)
    end
  end
 
  reaper.GetSetMediaTrackInfo_String(spectroTrack, "P_NAME", specname, true)
  reaper.SetMediaTrackInfo_Value(spectroTrack, 'B_MAINSEND', 0) 

  -- Fetch all the tracks
  reaper.SetMediaTrackInfo_Value(spectroTrack, "I_NCHAN", tracks*2)
  local targetidx = 0
  for i=0,tracks-1 do
    local track   = reaper.GetTrack(project, i)  

    local depth = reaper.GetTrackDepth(track)
    local ret, name = reaper.GetTrackName(track, "                                                              ")
    if ( name ~= "MASTER" and ( depth == 0 ) ) then
      local sendidx = reaper.CreateTrackSend(track, spectroTrack)
      local sn = reaper.SetTrackSendInfo_Value(track, 0, sendidx, "I_DSTCHAN", 2*targetidx)
      targetidx = targetidx + 1;
    end
  end
  
  -- Add spectrum track
  if ( exists == 0 ) then
    local tfx = reaper.TrackFX_AddByName(spectroTrack, "SaikeMultiSpectralAnalyzer_alt.jsfx", 0, -1)
  end
  reaper.TrackFX_SetOpen(spectroTrack, 0, true)
  reaper.TrackFX_Show(spectroTrack, 0, 0)  
  reaper.TrackFX_Show(spectroTrack, 0, 3)
  --local hwnd = reaper.TrackFX_GetFloatingWindow(spectroTrack, 0)  
  
  reaper.Undo_EndBlock( 'Added spectrograph', -1 )
end

Main()

