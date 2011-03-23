-- Simple simulation of a star and planet(s)
-- to familiarize ourselves with love graphics primitives.
--
-- Evan Dorn and Kiri Wagstaff, 3/21/2011
require 'screen_scale'

scale = ScreenScale:new()
scale.screen_scale = 2e9

ndraws = 0

CENTER = { x = 200, y = 300 }
MARS_ORBIT_RADIUS = 2.28e8
EARTH_ORBIT_RADIUS = 1.49e8
JUPITER_ORBIT_RADIUS = 7.8e8 -- km

SPEED = .01 -- radians per paint?

function love.draw()
    love.graphics.setColor(255,255,255)
    -- love.graphics.print("I Love Kiri!", 500, 300)
    love.graphics.print(string.format("%d draws.", ndraws), 20, 10)
    love.graphics.setColor(200, 200, 0)
    love.graphics.circle("fill", scale.screen_center.x, scale.screen_center.y, 20, 50)

    -- Draw a planet
    x, y = scale:screenCoords(orbit_coords(ndraws, SPEED, MARS_ORBIT_RADIUS))
    love.graphics.setColor(200, 0, 0) -- Mars
    love.graphics.circle("fill", x, y, 5, 50)
    love.graphics.print("Mars", x+12, y-5);

    x, y = scale:screenCoords(orbit_coords(ndraws, SPEED, EARTH_ORBIT_RADIUS))
    love.graphics.setColor(50, 60, 200) -- Earth
    love.graphics.circle("fill", x,y, 5, 50)
    love.graphics.print("Earth", x+12, y-5);

    x, y = scale:screenCoords(orbit_coords(ndraws, SPEED, JUPITER_ORBIT_RADIUS))
    love.graphics.setColor(250, 70, 70) -- Jupiter
    love.graphics.circle("fill", x,y, 10, 50)
    -- love.graphics.setColor(150, 20, 10) -- Jupiter
    -- love.graphics.circle("fill", x+6, y+4, 10, 20)

    ndraws = ndraws + 1
end

function orbit_coords(ndraws, speed, radius)
  x = (math.sin(ndraws * speed) * radius)
  y = (math.cos(ndraws * speed) * radius)
  return x, y
end
