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
  stars = require 'initialize_stars'
  planets = require 'initialize_planets'
  planets.mars.host  = stars.sol
  planets.earth.host = stars.sol
  planets.luna.host  = planets.earth
end

function love.update(delta_time)
  time = time + delta_time * time_scale
  for _, planet in pairs(planets) do planet:updateCoords(time) end
end

function love.draw()
    love.graphics.setColor(255,255,255)
    love.graphics.print(string.format("Time scale: %s to 1", time_scale), 20, 10)
    love.graphics.print("('Up' to speed up, 'down' to slow down)", 20, 22)
    love.graphics.print(string.format("Time: %.3f seconds", time), 20, 40)
    love.graphics.print(string.format("Draws: %d", ndraws), 20, 52)
    love.graphics.print("I Love Kiri!", 20, 64)
    love.graphics.print(string.format("Press 'q' to quit."), 20, 
			love.graphics.getHeight()-20)

    -- Draw stars
    for _, star in pairs(stars) do star:draw(scale) end

    -- Draw planets
    for _, planet in pairs(planets) do planet:draw(scale) end

    ndraws = ndraws + 1
end

function love.keypressed(k)
   if k == 'escape' or k == 'q' then
      love.event.push('q') -- quit the game
   elseif k == 'up' then
      time_scale = time_scale * 1.5
   elseif k == 'down' then
      time_scale = time_scale / 1.5
   end
end
