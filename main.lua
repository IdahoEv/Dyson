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

function love.draw()
    love.graphics.setColor(255,255,255)
    love.graphics.print(string.format("Time scale: %s to 1", time_scale), 20, 10)
    love.graphics.print(string.format("Time: %.3f seconds", time), 20, 22)
    love.graphics.print(string.format("Draws: %d", ndraws), 20, 34)
    love.graphics.print("I Love Kiri!", 20, 46)
    love.graphics.print(string.format("Press 'q' to quit."), 20, 
			love.graphics.getHeight()-20)

    love.graphics.setColor(200, 200, 0)
    love.graphics.circle("fill", 
			 scale.screen_center.x, scale.screen_center.y, 
			 20, 50)

    -- Draw planets
    for _, planet in ipairs(planets) do planet:draw(scale) end

    ndraws = ndraws + 1
end

function love.keypressed(k)
    if k == 'escape' or k == 'q' then
        love.event.push('q') -- quit the game
    end
end
