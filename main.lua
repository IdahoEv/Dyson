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

function love.keypressed(key, unicode)
  if      key == 'right'  then time_scale = time_scale * 2
  elseif  key == 'left'   then time_scale = time_scale / 2
  elseif  key == 'up'     then scale:zoomIn()
  elseif  key == 'down'   then scale:zoomOut()
  elseif  key == 'f'      then toggleFullscreen()
  elseif  key == 'escape' or key == 'q' then love.event.push('q')
  elseif  key == 'p'      then preferences.toggle('enlarge_planets')
  elseif  key == 'o'      then preferences.toggle('show_orbits')
  elseif  key == 'r'      then preferences.toggle('show_reticle')
  end
end


function love.draw()
    love.graphics.setColor(255,255,255)
    love.graphics.print(string.format("Time scale: %s to 1", time_scale), 20, 10)
    love.graphics.print("('right' to speed up, 'left' to slow down)", 20, 24)
    love.graphics.print("('up' to zoom in, 'down' to zoom out)", 20, 38)
    love.graphics.print(string.format("Time: %.0f sec (%d years, %d days)", time,
        time / SECONDS_PER_YEAR,
        (time % SECONDS_PER_YEAR) / SECONDS_PER_DAY ),
        20, 52)
    love.graphics.print(string.format("FPS: %d", fps), 20, 66)
    love.graphics.print("I Love Kiri!", 20, 80)
    love.graphics.print(string.format("Press 'q' to quit."), 20,
			love.graphics.getHeight()-20)

    -- Draw stars
    for _, star in pairs(stars) do star:draw(scale) end

    -- Draw planets
    for _, planet in ipairs(planets) do planet:draw(scale) end

    ndraws = ndraws + 1
end
