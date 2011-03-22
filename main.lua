ndraws = 0

CENTER = { x = 200, y = 300 }
MARS_RADIUS = 150
EARTH_RADIUS = 100
JUPITER_RADIUS = 250

SPEED = 4

function love.draw()
    love.graphics.setColor(255,255,255)
    love.graphics.print("I Love Kiri!", 500, 300)
    love.graphics.print(string.format("%d draws.", ndraws), 400, 350)
    love.graphics.setColor(200, 200, 0)
    love.graphics.circle("fill", CENTER.x, CENTER.y, 50, 50)

    -- Draw a planet
    x, y = orbit_coords(ndraws, SPEED, MARS_RADIUS, CENTER)
    love.graphics.setColor(200, 0, 0) -- Mars
    love.graphics.circle("fill", x, y, 10, 50)

    x, y = orbit_coords(ndraws, SPEED, EARTH_RADIUS, CENTER)
    love.graphics.setColor(50, 60, 200) -- Earth
    love.graphics.circle("fill", x, y, 10, 50)

    x, y = orbit_coords(ndraws, SPEED, JUPITER_RADIUS, CENTER)
    love.graphics.setColor(250, 70, 70) -- Jupiter
    love.graphics.circle("fill", x, y, 30, 50)
    love.graphics.setColor(150, 20, 10) -- Jupiter
    love.graphics.circle("fill", x+6, y+4, 10, 20)

    ndraws = ndraws + 1
end

function orbit_coords(ndraws, speed, radius, center)
  x = (math.sin(ndraws * speed / radius) * radius) + center.x
  y = (math.cos(ndraws * speed / radius) * radius) + center.y
  return x, y
end