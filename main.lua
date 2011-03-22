-- Simple simulation of a star and planet(s)
-- to familiarize ourselves with love graphics primitives.
--
-- Evan Dorn and Kiri Wagstaff, 3/21/2011

require "Spob" -- Space Object class

ndraws = 0

CENTER = { x = 200, y = 300 }
MARS_ORBITAL_RADIUS = 150
EARTH_ORBITAL_RADIUS = 100
MARS_RADIUS = 10
EARTH_RADIUS = 15
SPEED = 3

function love.draw()
    love.graphics.setColor(255,255,255)
    love.graphics.print("I Love Kiri!", 500, 300)
    love.graphics.print(string.format("%d draws.", ndraws), 400, 350)
    love.graphics.setColor(200, 200, 0)
    love.graphics.circle("fill", CENTER.x, CENTER.y, 50, 50)

    -- Draw a planet
    mars = Spob:new() -- Mars
    mars:setName("Mars")
    mars:setColor({ R = 200, G = 0, B = 0 })
    mars:setRadius(MARS_RADIUS)
    mars:setOrbitalRadius(MARS_ORBITAL_RADIUS)
    mars:setSpeed(SPEED)  -- probably setPeriod() instead, next
    mars:setCenter(CENTER)
    mars:draw(ndraws)  -- ndraws stands in for time

    earth = Spob:new() -- Earth
    earth:setName("Earth")
    earth:setColor({ R = 50, G = 60, B = 200 })
    earth:setRadius(EARTH_RADIUS)
    earth:setOrbitalRadius(EARTH_ORBITAL_RADIUS)
    earth:setSpeed(SPEED)  -- probably setPeriod() instead, next
    earth:setCenter(CENTER)
    earth:draw(ndraws)  -- ndraws stands in for time

    ndraws = ndraws + 1
end

