-- Simple simulation of a star and planet(s)
-- to familiarize ourselves with love graphics primitives.
--
-- Evan Dorn and Kiri Wagstaff, 3/21/2011
require 'screen_scale'
require "Sphere" -- Space Object class
require 'constants'
require 'screen_size'
require 'inspector'
require 'fps'
require 'preferences'
require 'text'
require 'help'
-- require 'profiler'

function love.load()
--  profiler.start()
  initializeScreen()
  scale = ScreenScale:new()
  scale.screen_scale = 0.6e9
  ndraws = 0
  time = 0

  time_scale = 5e6
  sol     = require 'initialize_solar_system'
  scale.view_center = sol
  planets = sol.satellites
  -- planets = require 'initialize_planets'
  sol:printHierarchy()
  stars = require 'initialize_stars'
  table.insert(stars, sol)
  inspectors = { }

  fullscreen = false
  initializeFPS()
end

function love.update(delta_time)
  if not preferences.pause_time then
    time = time + delta_time * time_scale
    for _, spob in ipairs(stars) do spob:updateCoords(time) end
  end

  updateFPS(delta_time)
  visible_spobs = findVisibleSpobs(stars)
end

function love.keypressed(key, unicode)
  -- print(key, unicode)
  if      key == 'right'  then time_scale = time_scale * 2
  elseif  key == 'left'   then time_scale = time_scale / 2
  elseif  key == 'up'     then scale:zoomIn(KEYBOARD_ZOOM_FACTOR)
  elseif  key == 'down'   then scale:zoomOut(KEYBOARD_ZOOM_FACTOR)
  elseif  key == 'f'      then toggleFullscreen()
  elseif  key == 'q'      then 
--    profiler.stop()
    love.event.push('q')
  elseif  key == ' '      then preferences.toggle('pause_time')
  elseif  key == 'p'      then preferences.toggle('enlarge_planets')
  elseif  key == 'o'      then preferences.toggle('show_orbits')
  elseif  key == 'r'      then preferences.toggle('show_reticle')
  elseif  key == 'escape' then
    inspectors = { }
    preferences['pause_time'] = false
  elseif  key == '0' and
     (love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift')) then
     scale.view_center = sol
  elseif  key >= '1' and key <= '9' and tonumber(key) <= #planets and
     (love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift')) then
     scale.view_center = planets[tonumber(key)]
  elseif  key == '?' or key == '/' then preferences.toggle('show_help')
  end
end

function love.mousepressed(x, y, button)
  local spob = findClickedSphere(x, y, visible_spobs)
  if button == 'l' then
    if spob then scale.view_center = spob end
  elseif  button == 'r'  then
    if spob then table.insert(inspectors, Inspector:new(spob)) end
  elseif  button == 'wu' then scale:zoomIn(MOUSE_ZOOM_FACTOR)
  elseif  button == 'wd' then scale:zoomOut(MOUSE_ZOOM_FACTOR)
  end
end

-- given screen coordinates (i.e. a mouse click), find the spob from the list
-- that is closest to the click, if it is within the click tolerance
function findClickedSphere(x, y, spobs)
  local best_proximity = CLICK_TOL
  local dist = 0
  local best_spob = nil
  for _, spob in ipairs(spobs) do
    sx, sy = scale:screenCoords(spob:getLocation())
    dist = math.sqrt( (sx-x)^2 + (sy-y)^2 )
    -- print(spob.name, "click", x, y, 'spob', sx, sy, 'dist', dist)
    if dist < best_proximity then
      -- print('best yet:', spob.name)
      best_proximity = dist
      best_spob = spob
    end
  end
  -- if best_spob then
  --   print('**** Best spob:', best_spob.name)
  -- end
  return best_spob
end

function love.draw()
  textLine{str={"Time scale: %s to 1", time_scale}, x=LEFT_MARGIN, y=TOP_MARGIN}
  textLine{str={"Time: %.0f sec (%d years, %d days)", time,
        time / SECONDS_PER_YEAR,
        ((time % SECONDS_PER_YEAR) / SECONDS_PER_DAY )}}
  textLine{str={string.format("FPS: %d", fps)}}
  textLine{str = "Press 'q' to quit, '?' for help.", y = BOTTOM_MARGIN }
  textLine{str = "E + K!", x = HELP_MARGIN, y = BOTTOM_MARGIN }

  if preferences.show_help then drawHelp() end

  -- draw the visible spobs
  for _, spob in pairs(visible_spobs) do spob:draw(scale) end

  -- Draw inspectors
  -- If there are any, set pause on
  if #inspectors > 0 then preferences['pause_time'] = true end
  for i, ins in pairs(inspectors) do
    ins:draw(scale)
  end

  ndraws = ndraws + 1
end

-- Naive first version just iterates the stars to see if they are within a delta of onscreen,
-- and adds their satellites if those satellites' orbits aren't too small
function findVisibleSpobs(stars_to_check)
  local vspobs = {}
  local ALLOWABLE_DISTANCE = 2 -- screen heights
  local MIN_RESOLVABLE     = 5 -- pixels
  local max_dist = ALLOWABLE_DISTANCE * scale.screen_scale
  local min_dist = MIN_RESOLVABLE / scale.screen_height * scale.screen_scale

  local function appendVisibleSpobsAndSatellites(vspobs, spob_array)
    for _, spob in ipairs(spob_array) do
      --if spob.class == Centroid or (spob.host and spob.host.name == "Centauri System") then
--	print('checking visibility: ', spob.class, spob.name, dist_from_center, max_dist, '-', dist_from_host, min_dist)
--      end
      if spob:isVisible(min_dist, max_dist) then
        table.insert(vspobs, spob)
        if #(spob.satellites) > 0 then
          appendVisibleSpobsAndSatellites(vspobs, spob.satellites)
        end
      else
        -- Recurse on satellites of invisible spobs too,
        -- if they happen to be Centroids.
        if instanceOf(Centroid, spob) then
          appendVisibleSpobsAndSatellites(vspobs, spob.satellites)
        end
      end
    end
  end

  if scale.view_center then
    -- Check visibility, since Centroid Spheres may not be visible
    if scale.view_center:isVisible(min_dist, max_dist) then
      table.insert(vspobs, scale.view_center)
    end
    appendVisibleSpobsAndSatellites(vspobs, scale.view_center.satellites)
  end
  appendVisibleSpobsAndSatellites(vspobs, stars_to_check)
  --print('------------------- VISIBLE:---------------')
  --for _, spob in ipairs(vspobs) do print(spob.name) end
  return vspobs
end



