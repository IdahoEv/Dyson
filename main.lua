ndraws = 0

CENTER = { x = 150, y = 300 }
ORBIT_RADIUS = 150
SPEED = 1 / 50

function love.draw()
    love.graphics.setColor(255,255,255)
    love.graphics.print("Hello Kiri!", 400, 300)
    love.graphics.print(string.format("%d draws.", ndraws), 400, 350)
    love.graphics.setColor(200, 200, 0)
    love.graphics.circle("fill", CENTER.x, CENTER.y, 50, 50)


    x = (math.sin(ndraws * SPEED) * ORBIT_RADIUS) + CENTER.x
    y = (math.cos(ndraws * SPEED) * ORBIT_RADIUS) + CENTER.y

    -- Draw a planet
    love.graphics.setColor(200, 0, 0) -- Mars
    love.graphics.circle("fill", x, y, 10, 50)

    ndraws = ndraws + 1
end
