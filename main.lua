-- Simple simulation of a star and planet(s)
-- to familiarize ourselves with love graphics primitives.
--
-- Evan Dorn and Kiri Wagstaff, 3/21/2011
require 'screen_scale'
require "Spob" -- Space Object class
require 'constants'
require 'screen_size'
require 'inspector'
require 'fps'
require 'preferences'
require 'text'
require 'help'

function love.load()
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
  if preferences.pause_time then return end

  time = time + delta_time * time_scale
  updateFPS(delta_time)
  for _, planet in ipairs(planets) do planet:updateCoords(time) end

  visible_spobs = findVisibleSpobs(stars)
end

function love.keypressed(key, unicode)
  -- print(key, unicode)
  if      key == 'right'  then time_scale = time_scale * 2
  elseif  key == 'left'   then time_scale = time_scale / 2
  elseif  key == 'up'     then scale:zoomIn(KEYBOARD_ZOOM_FACTOR)
  elseif  key == 'down'   then scale:zoomOut(KEYBOARD_ZOOM_FACTOR)
  elseif  key == 'f'      then toggleFullscreen()
  elseif  key == 'q'      then love.event.push('q')
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
  if button == 'l' then
    -- left-click: center on spob
    -- find nearby-ish spob
    for _, planet in ipairs(planets) do
      local px, py = scale:screenCoords(planet:getLocation())
      if math.abs(px - x) < CLICK_TOL and
        math.abs(py - y) < CLICK_TOL then
        scale.view_center = planet
      end
    end
    for _, star in pairs(stars) do
      local sx, sy = scale:screenCoords(star:getLocation())
      if math.abs(sx - x) < CLICK_TOL and
        math.abs(sy - y) < CLICK_TOL then
        scale.view_center = star
      end
    end
  elseif  button == 'r'  then
    -- right-click: recenter at origin
    --scale.view_center = nil
    --scale:resetZoom()
    -- right-click: bring up inspector
    -- find nearby-ish spob
    for _, planet in ipairs(planets) do
      local px, py = scale:screenCoords(planet:getLocation())
      if math.abs(px - x) < CLICK_TOL and
        math.abs(py - y) < CLICK_TOL then
        table.insert(inspectors, Inspector:new(planet))
      end
    end
  elseif  button == 'wu' then scale:zoomIn(MOUSE_ZOOM_FACTOR)
  elseif  button == 'wd' then scale:zoomOut(MOUSE_ZOOM_FACTOR)
  end
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

  -- Recursively draw stars (and their children planets)
  for _, star in pairs(stars) do star:draw(scale) end

  -- Draw planets
  --for _, planet in ipairs(planets) do planet:draw(scale) end

  -- Draw inspectors
  -- If there are any, set pause on
  if #inspectors > 0 then preferences['pause_time'] = true end
  for i, ins in pairs(inspectors) do
    ins:draw(scale)
  end

  ndraws = ndraws + 1
end

function drawHelp()
  textLine{str = "Key Commands:", x = HELP_MARGIN, y = TOP_MARGIN }
  textLine{str = "right/left: change speed"}
  textLine{str = "up/down: zoom"}
  textLine{str = "shift+0: recenter to star (Sol)"}
  textLine{str = "shift+<n>: recenter to planet n"}
  textLine{str = 'f: toggle fullscreen'}
  textLine{str = 'p: toggle enlarge planets'}
  textLine{str = 'o: toggle show orbits'}
  textLine{str = 'r: toggle planet reticles'}
  textLine{str = '<space>: pause'}
  textLine{str = 'q: quit'}
  textLine{str = ''}
  textLine{str = 'Left-click to recenter on a spob'}
  textLine{str = 'Right-click to recenter at origin'}
end

-- Naive first version just iterates the stars to see if they are within a delta of onscreen,
-- and adds their satellites if those satellites' orbits aren't too small
function findVisibleSpobs(stars)
  local vspobs = {}

  local function appendVisibleSpobsAndSatellites(vspobs, spob_array)
    local ALLOWABLE_DISTANCE = 2 -- screen heights
    local MIN_RESOLVABLE     = 5 -- pixels
    local max_dist = ALLOWABLE_DISTANCE * scale.screen_scale
    local min_dist = MIN_RESOLVABLE / scale.screen_height * scale.screen_scale
    for _, spob in ipairs(spob_array) do
      local dist_from_center  = spob:distanceFromPoint(scale:viewCenterLocation())
      local dist_from_host    = spob:distanceFromParent()

      if (dist_from_center < max_dist) and (dist_from_host > min_dist) then
        table.insert(vspobs, star)
        if #(spob.satellites) > 0 then
          appendVisibleSpobsAndSatellites(vspobs, spob.satellites)
        end
      end
    end
  end
  if scale.view_center then
    table.insert(vspobs, scale.view_center)
    appendVisibleSpobsAndSatellites(vspobs, scale.view_center.satellites)
  end
  appendVisibleSpobsAndSatellites(vspobs, stars)
  return vspobs
end



