-- Simple simulation of a star and planet(s)
-- to familiarize ourselves with love graphics primitives.
--
-- Evan Dorn and Kiri Wagstaff, 3/21/2011

ndraws = 0

function love.draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Hello Kiri!", 400, 300)
    love.graphics.print(string.format("%d draws.", ndraws), 400, 350)
    love.graphics.setColor(200, 200, 0)
    love.graphics.circle("fill", 100, 300, 50, 50)

    -- Draw a planet
    love.graphics.setColor(200, 0, 0) -- Mars 
    love.graphics.circle("fill", ndraws/10, ndraws/10, 10, 50)
    love.graphics.print("Mars", ndraws/10+12, ndraws/10-5);

    love.graphics.setColor(0, 0, 200) -- Earth
    love.graphics.circle("fill", 400-ndraws/10, ndraws/10, 10, 50)
    love.graphics.print("Earth", 400-ndraws/10+12, ndraws/10-5);

    ndraws = ndraws + 1
end
