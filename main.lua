-- Simple simulation of a star and planet(s)
-- to familiarize ourselves with love graphics primitives.
--
-- Evan Dorn and Kiri Wagstaff, 3/21/2011
require 'screen_scale'
require "Spob" -- Space Object class
require 'constants'
require 'screen_size'
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
  stars   = require 'initialize_stars'
  planets = require 'initialize_planets'
  -- set all planets to orbit the sun unless they already have a host
  for _, planet in ipairs(planets) do
    if not planet.host then planet.host = stars.sol end
  end

  fullscreen = false
  initializeFPS()
end

function love.update(delta_time)
  time = time + delta_time * time_scale
  updateFPS(delta_time)
  for _, planet in ipairs(planets) do planet:updateCoords(time) end
end

function love.mousepressed(x, y, button)

end

function love.keypressed(key, unicode)
  -- print(key, unicode)
  if      key == 'right'  then time_scale = time_scale * 2
  elseif  key == 'left'   then time_scale = time_scale / 2
  elseif  key == 'up'     then scale:zoomIn(KEYBOARD_ZOOM_FACTOR)
  elseif  key == 'down'   then scale:zoomOut(KEYBOARD_ZOOM_FACTOR)
  elseif  key == 'f'      then toggleFullscreen()
  elseif  key == 'escape' or key == 'q' then love.event.push('q')
  elseif  key == 'p'      then preferences.toggle('enlarge_planets')
  elseif  key == 'o'      then preferences.toggle('show_orbits')
  elseif  key == 'r'      then preferences.toggle('show_reticle')
  elseif  key == '?' or key == '/' then preferences.toggle('show_help')
  end
end

function love.mousepressed(x, y, button)
  if button == 'l' then
    -- zoom in to spob on left-click
    -- find nearby-ish spob
    for _, planet in ipairs(planets) do
      px, py = planet:getCoords(scale)
      if math.abs(px - x) < CLICK_TOL and
        math.abs(py - y) < CLICK_TOL then
        scale.view_center = planet
      end
    end
    for _, star in pairs(stars) do
      sx, sy = star:getCoords(scale)
      if math.abs(sx - x) < CLICK_TOL and
        math.abs(sy - y) < CLICK_TOL then
        scale.view_center = star
      end
    end
  elseif  button == 'r'  then scale.view_center = nil
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

  -- Draw stars
  for _, star in pairs(stars) do star:draw(scale) end

  -- Draw planets
  for _, planet in ipairs(planets) do planet:draw(scale) end

  ndraws = ndraws + 1
end

function drawHelp()
  textLine{str = "Key Commands:", x = HELP_MARGIN, y = TOP_MARGIN }
  textLine{str = "right/left: change speed"}
  textLine{str = "up/down: zoom"}
  textLine{str = 'f: toggle fullscreen'}
  textLine{str = 'p: toggle enlarge planets'}
  textLine{str = 'o: toggle show orbits'}
  textLine{str = 'r: toggle planet reticles'}
  textLine{str = 'q: quit'}
  textLine{str = ''}
  textLine{str = 'Left-click to recenter on a spob'}
  textLine{str = 'Right-click to recenter at origin'}
end

