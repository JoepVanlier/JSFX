--[[
@description Multi-channel spectral analyzer.
@author Joep Vanlier
@provides
  [main] .
@links 
  https://github.com/JoepVanlier/JSFX
@license MIT
@version 0.84
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
--]] --[[
 * Changelog:
 * v0.84 (2023-02-06)
   + Wipe hash if we deleted the spectral analyzer (thanks Feed The Cat).
 * v0.83 (2020-08-11)
   + Force track volume.
 * v0.82 (2020-07-30)
   + Fix bug that led to channels starting with zero in color not parsing correctly because they were being interpreted as terminator.
 * v0.8 (2020-02-29)
   + Pulled in modifications from Feed The Cat.
 * v0.71 (2018-11-11)
   + Some file renaming going on.
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
   + Added 'OFF' option for sonogram/time window
   + Added solo (doubleclick on a channel)
   + Do not recreate spectrum track when it already exists, but merely add/remove channels
   + Only add top level channels to avoid adding channels multiple times
]]
local always_use_track_colors = false

reaper.Undo_BeginBlock()

function print(msg)
    reaper.ShowConsoleMsg(tostring(msg) .. '\n')
end

local use_volume = false
local GetProjExtState = reaper.GetProjExtState
local SetProjExtState = reaper.SetProjExtState
local GetSetTrackInfoStr = reaper.GetSetMediaTrackInfo_String
local GetTrackInfo = reaper.GetMediaTrackInfo_Value
local SetTrackInfo = reaper.SetMediaTrackInfo_Value
local SetSendInfo = reaper.SetTrackSendInfo_Value

local track_spec
local track_spec_name = 'Spectrum'
local extname = 'saike_spectrum_analyzer'

local track_cnt = reaper.CountTracks(0)
local track_sel_cnt = reaper.CountSelectedTracks(0)

-- Find tracks to show in analyzer
local tracks = {}

-- Case: More than one track is selected
if track_sel_cnt >= 2 then
    for i = 0, track_sel_cnt - 1 do
        local track_sel = reaper.GetSelectedTrack(0, i)
        -- Check if selected track matches spectrum track
        if track_sel ~= track_spec then
            tracks[#tracks + 1] = track_sel
        elseif track_sel_cnt == 2 then
            -- Edge Case: One of two selected tracks is track_spec
            tracks = {}
            break
        end
    end
end

-- Case: All tracks can be shown
if #tracks == 0 and track_cnt <= 17 then
    for i = 0, track_cnt - 1 do
        local track = reaper.GetTrack(0, i)
        if track ~= track_spec then
            tracks[#tracks + 1] = track
        end
    end
end

-- Case: Default (Show tracks with no depth, preferably no receives)
if #tracks == 0 then
    local tracks_alt = {}
    for i = 0, track_cnt - 1 do
        local track = reaper.GetTrack(0, i)
        local fdepth = reaper.GetTrackDepth(track)
        -- Check for folder depth
        if track ~= track_spec and fdepth == 0 then
            tracks[#tracks + 1] = track
            -- Keep alternative list with tracks with no receives
            local recvs = reaper.GetTrackNumSends(track, -1)
            if recvs == 0 then
                tracks_alt[#tracks_alt + 1] = track
            end
        end
    end
    -- Swap to alternative list with no receives
    if #tracks > 16 then
        tracks = tracks_alt
    end
end

-- Limit tracks to 16
if #tracks > 16 then
    for i = #tracks, 17, -1 do
        tracks[i] = nil
    end
end

local ret, track_spec_guid = GetProjExtState(0, extname, 'guid')
if ret then
    -- Find old track based on GUID
    for i = track_cnt - 1, 0, -1 do
        local track = reaper.GetTrack(0, i)
        local guid = reaper.GetTrackGUID(track)
        local guid_str = reaper.guidToString(guid, '')
        if track_spec_guid == guid_str then
            track_spec = track
            break
        end
    end
end

if not track_spec then
    -- Reset project hash in case track was deleted
    SetProjExtState(0, extname, 'hash', '')
    -- Create spectrum track at the end
    reaper.InsertTrackAtIndex(track_cnt, true)
    track_spec = reaper.GetTrack(0, track_cnt)
    track_cnt = track_cnt + 1
    -- Save track guid
    local guid = reaper.GetTrackGUID(track_spec)
    local guid_str = reaper.guidToString(guid, '')
    SetProjExtState(0, extname, 'guid', guid_str)
    -- Set track info
    GetSetTrackInfoStr(track_spec, 'P_NAME', track_spec_name, true)
    SetTrackInfo(track_spec, 'B_MAINSEND', 0)
    SetTrackInfo(track_spec, 'I_NCHAN', math.min(16, #tracks) * 2)
else
    -- Remove existing track sends
    for i = reaper.GetTrackNumSends(track_spec, -1) - 1, 0, -1 do
        reaper.RemoveTrackSend(track_spec, -1, i)
    end
end

-- Set up track sends
for i, track in ipairs(tracks) do
    local send_idx = reaper.CreateTrackSend(track, track_spec)
    SetSendInfo(track, 0, send_idx, 'I_DSTCHAN', 2 * (i - 1))
    
    if use_volume then
      local retval, volume, pan = reaper.GetTrackUIVolPan(track)
      SetSendInfo(track, 0, send_idx, 'D_VOL', volume)
    else
      SetSendInfo(track, 0, send_idx, 'D_VOL', 1.0)
    end
end

-- Set up track titles/colors in gmem for jsfx
if reaper.gmem_write then
    -- Note: reaper.APIExists() does work for gmem_write
    reaper.gmem_attach(extname)
    -- Check if track colors should be used
    local use_track_colors = true
    if not always_use_track_colors then
        -- Count unique track colors
        local colors = {}
        for i, track in ipairs(tracks) do
            local color = reaper.GetTrackColor(track)
            local c = tostring(color)
            -- Count color occurence in an associative table
            colors[c] = colors[c] and colors[c] + 1 or 1
        end
        -- Avoid using too many same colored tracks
        for _, ccnt in pairs(colors) do
            if ccnt > 1 and ccnt > #tracks / 3 then
                use_track_colors = false
            end
        end
    end

    -- Start at memory addr 1 (0 is reserved for type)
    local mem_addr = 1
    -- Write data to gmem
    for i, track in ipairs(tracks) do
        -- Write track color to gmem (RGB)
        if use_track_colors then
            local r, g, b = 120, 120, 120
            local color = reaper.GetTrackColor(track)
            if color > 0 then
                r, g, b = reaper.ColorFromNative(color)
                -- Brigthen up colors a bit
                if math.max(r, math.max(g, b)) < 220 then
                    r, g, b = r + 15, g + 15, b + 15
                end
            end
            reaper.gmem_write(mem_addr + 0, r)
            reaper.gmem_write(mem_addr + 1, g)
            reaper.gmem_write(mem_addr + 2, b)
            mem_addr = mem_addr + 3
            
            --reaper.ShowConsoleMsg(string.format("%d %d %d ", r, g, b));
        end
        -- Write track name to gmem in ASCII bytes
        local ret, name = reaper.GetTrackName(track, '')
        local tnum = GetTrackInfo(track, 'IP_TRACKNUMBER')
        name = ret and name or 'Track ' .. tnum
        for i = 1, #name do
            local byte = string.byte(name, i)
            -- Replace non ASCII characters with underscores
            if byte > 127 then
                -- Avoid double underscores
                if i > 0 and string.byte(name, i - 1) > 127 then
                    mem_addr = mem_addr - 1
                end
                byte = 95
            end
            reaper.gmem_write(mem_addr, byte)
            --reaper.ShowConsoleMsg(string.format("%s ", string.char(byte)));
            mem_addr = mem_addr + 1
        end
        -- Write negative ones to gmem to signal string end
        reaper.gmem_write(mem_addr, 256)
        reaper.gmem_write(mem_addr + 1, 256)
        mem_addr = mem_addr + 1
    end
    -- Edge case: No tracks
    if #tracks == 0 then
        reaper.gmem_write(0, 1)
        reaper.gmem_write(1, 256)
    else
        -- Notify jsfx about write (and write type)
        reaper.gmem_write(0, use_track_colors and 2 or 1)
    end
end

-- Add/Get/Open analyzer jsfx
local fx_name = 'SaikeMultiSpectralAnalyzer.jsfx'
local fx = reaper.TrackFX_AddByName(track_spec, fx_name, false, 1)
if reaper.TrackFX_GetChainVisible(track_spec) ~= fx then
    reaper.TrackFX_Show(track_spec, fx, 3)
end

function dirtyHash(tracks)
    local hash = 0
    for i, track in ipairs(tracks) do
        local tnum = GetTrackInfo(track, 'IP_TRACKNUMBER')
        hash = hash + i * tnum
    end
    return hash
end

-- Calculate a quick hash of currently shown tracks
local hash = dirtyHash(tracks)
local ret, hash_old = GetProjExtState(0, extname, 'hash')

-- Note: Put stuff here that only runs when shown tracks changed
if not ret or hash ~= tonumber(hash_old) then
    -- Set all used jsfx channels to open
    for i = 1, 16 do
        local val = i <= #tracks and 1 or 0
        reaper.TrackFX_SetParam(track_spec, fx, 9 + i, val)
    end
end

-- Save old hash for comparison on next run
SetProjExtState(0, extname, 'hash', hash)

reaper.Undo_EndBlock('Load Spectrum', -1)
