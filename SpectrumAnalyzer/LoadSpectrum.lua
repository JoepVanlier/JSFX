--[[
@description Spectral analyzer call script.
@author: Joep Vanlier
@provides
  [main] .
  SaikeMultiSpectralAnalyzer.jsfx
@links
  https://github.com/JoepVanlier/JSFX
@license MIT
@version 0.1
@about ### Multi-Channel Spectral Analyzer
  This script opens the JSFX multispectrum analyzer on a new FX track.
  It will automatically route up to 16 channels to this FX and open the window.
--]]
--[[
 * Changelog:
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

  local oldParams

  -- Kill a spectro channel if it already exists
  for i=0,tracks-1 do
    local track   = reaper.GetTrack(project, i)    
    local ret, name = reaper.GetTrackName(track, "                                                              ")
    
    if ( name == specname ) then
      -- Fetch the old spectro settings if there's already one here
      local count = reaper.TrackFX_GetNumParams(track, 0);
      
      -- Store old settings
      oldParams = {}
      for i=0,count-1 do
        oldParams[i] = reaper.TrackFX_GetParam(track, 0, i)
      end
      reaper.DeleteTrack(track)
      tracks = tracks - 1;
    end
  end
  
  -- Create track at the end
  reaper.InsertTrackAtIndex(tracks, true)
  local spectroTrack = reaper.GetTrack(project, tracks)
  reaper.GetSetMediaTrackInfo_String(spectroTrack, "P_NAME", specname, true)
  reaper.SetMediaTrackInfo_Value(spectroTrack, 'B_MAINSEND', 0) 

  -- Fetch all the tracks
  reaper.SetMediaTrackInfo_Value(spectroTrack, "I_NCHAN", tracks*2)
  for i=0,tracks-1 do
    local track   = reaper.GetTrack(project, i)  

    local ret, name = reaper.GetTrackName(track, "                                                              ")
    if ( name ~= "MASTER" ) then  
      local sendidx = reaper.CreateTrackSend(track, spectroTrack)
      local sn = reaper.SetTrackSendInfo_Value(track, 0, sendidx, "I_DSTCHAN", 2*i)
    end
  end
  
  -- Add spectrum track
  local tfx = reaper.TrackFX_AddByName(spectroTrack, "SaikeMultiSpectralAnalyzer.jsfx", 0, -1)
  reaper.TrackFX_SetOpen(spectroTrack, 0, true)
  reaper.TrackFX_Show(spectroTrack, 0, 3)
  reaper.TrackFX_Show(spectroTrack, 0, 0)  
  local hwnd = reaper.TrackFX_GetFloatingWindow(spectroTrack, 0)
  
  reaper.Undo_EndBlock( 'Added spectrograph', -1 )
  
  -- Set back to old settings
  if ( oldParams ) then
    for i=0,#oldParams do
      reaper.TrackFX_SetParam(spectroTrack, 0, i, oldParams[i])
    end
  end
end

Main()

