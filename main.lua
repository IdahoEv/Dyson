-- Simple simulation of a star and planet(s)
-- to familiarize ourselves with love graphics primitives.
--
-- Evan Dorn and Kiri Wagstaff, 3/21/2011
require 'screen_scale'
require "Spob" -- Space Object class

function love.load()

  scale = ScreenScale:new()
  scale.screen_scale = 2e9


  ndraws = 0

  CENTER = { x = 200, y = 300 }
  MARS_ORBIT_RADIUS = 2.28e8 -- km
  EARTH_ORBIT_RADIUS = 1.49e8 --km
  JUPITER_ORBIT_RADIUS = 7.8e8 -- km

  SPEED = 1e7
  require 'initialize_planets'
end

function love.draw()
    love.graphics.setColor(255,255,255)
    -- love.graphics.print("I Love Kiri!", 500, 300)
    love.graphics.print(string.format("%d draws.", ndraws), 20, 10)
    love.graphics.setColor(200, 200, 0)
    love.graphics.circle("fill", scale.screen_center.x, scale.screen_center.y, 20, 50)

    -- Draw planets
    mars:draw(ndraws, scale)  -- ndraws stands in for time
    earth:draw(ndraws, scale)  -- ndraws stands in for time

    -- x, y = scale:screenCoords(orbit_coords(ndraws, SPEED, JUPITER_ORBIT_RADIUS))
    -- love.graphics.setColor(250, 70, 70) -- Jupiter
    -- love.graphics.circle("fill", x,y, 10, 50)
    -- love.graphics.setColor(150, 20, 10) -- Jupiter
    -- love.graphics.circle("fill", x+6, y+4, 10, 20)

    ndraws = ndraws + 1
end

