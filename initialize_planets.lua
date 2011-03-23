mars = Spob:new() -- Mars
mars:setName("Mars")
mars:setColor({ R = 200, G = 0, B = 0 })
mars:setRadius(MARS_RADIUS)
mars:setOrbitalRadius(MARS_ORBIT_RADIUS)
mars:setSpeed(SPEED)  -- probably setPeriod() instead, next
mars:setCenter(CENTER)

earth = Spob:new() -- Earth
earth:setName("Earth")
earth:setColor({ R = 50, G = 60, B = 200 })
earth:setRadius(EARTH_RADIUS)
earth:setOrbitalRadius(EARTH_ORBIT_RADIUS)
earth:setSpeed(SPEED)  -- probably setPeriod() instead, next
earth:setCenter(CENTER)
