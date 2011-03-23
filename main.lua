-- Simple simulation of a star and planet(s)
-- to familiarize ourselves with love graphics primitives.
--
-- Evan Dorn and Kiri Wagstaff, 3/21/2011
require 'screen_scale'
require "Spob" -- Space Object class
require 'constants'

function love.load()
  scale = ScreenScale:new()
  scale.screen_scale = 0.6e9
  ndraws = 0
  time = 0

  time_scale = 5e6
  planets = require 'initialize_planets'
end

function love.update(delta_time)
  time = time + delta_time * time_scale
  for _, planet in ipairs(planets) do planet:updateCoords(time) end
end

function love.keypressed(key, unicode)
  if      key == 'right'  then time_scale = time_scale * 2
  elseif  key == 'left'   then time_scale = time_scale / 2
  elseif  key == 'up'     then scale:zoomIn()
  elseif  key == 'down'   then scale:zoomOut()
  end
end

function love.draw()
    love.graphics.setColor(255,255,255)
    love.graphics.print(string.format("Time scale: %s to 1", time_scale), 20, 10)
    love.graphics.print(string.format("Time: %.3f seconds", time), 20, 22)
    love.graphics.print(string.format("Draws: %d", ndraws), 20, 34)
    love.graphics.print("I Love Kiri!", 20, 46)

    love.graphics.setColor(200, 200, 0)

    sun_radius = 6.955e5 * scale:pixelScale() * 10
    love.graphics.circle("fill",
       scale.screen_center.x, scale.screen_center.y,
       sun_radius, 50)

    -- Draw planets
    for _, planet in ipairs(planets) do planet:draw(scale) end

    ndraws = ndraws + 1
end

