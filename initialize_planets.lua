SECONDS_PER_DAY = 24 * 60 * 60
VENUS_ORBIT_RADIUS   = 1.08e8 -- km
EARTH_ORBIT_RADIUS   = 1.49e8 -- km
MARS_ORBIT_RADIUS    = 2.28e8 -- km
JUPITER_ORBIT_RADIUS = 7.8e8  -- km

VENUS_RADIUS = 6051.8
MARS_RADIUS  = 3393.0 -- km
EARTH_RADIUS = 6378.0 -- km

mercury = Spob:new() -- mercury
mercury:setName("Mercury")
mercury:setColor({ R = 100, G = 100, B = 60 })
mercury:setRadius(2437.9)
mercury:setOrbitalRadius(6.9e7) -- km
mercury:setOrbitalPeriod(87.969 * SECONDS_PER_DAY)
mercury:setCenter(CENTER)

venus = Spob:new() -- venus
venus:setName("Venus")
venus:setColor({ R = 50, G = 150, B = 200 })
venus:setRadius(VENUS_RADIUS)
venus:setOrbitalRadius(VENUS_ORBIT_RADIUS)
venus:setOrbitalPeriod(224.7 * SECONDS_PER_DAY)
venus:setCenter(CENTER)

earth = Spob:new() -- Earth
earth:setName("Earth")
earth:setColor({ R = 50, G = 60, B = 200 })
earth:setRadius(EARTH_RADIUS)
earth:setOrbitalRadius(EARTH_ORBIT_RADIUS)
earth:setOrbitalPeriod(365.25 * SECONDS_PER_DAY)
earth:setCenter(CENTER)

mars = Spob:new() -- Mars
mars:setName("Mars")
mars:setColor({ R = 200, G = 0, B = 0 })
mars:setRadius(MARS_RADIUS)
mars:setOrbitalRadius(MARS_ORBIT_RADIUS)
mars:setOrbitalPeriod(686 * SECONDS_PER_DAY)
mars:setCenter(CENTER)

jupiter = Spob:new() -- Jupiter
jupiter:setName("Jupiter")
jupiter:setColor({ R = 250, G = 100, B = 100 })
jupiter:setRadius(7.149e4)
jupiter:setOrbitalRadius(7.785e8)
jupiter:setOrbitalPeriod(4331.6 * SECONDS_PER_DAY)
jupiter:setCenter(CENTER)

saturn = Spob:new() -- Saturn
saturn:setName("Saturn")
saturn:setColor({ R = 200, G = 200, B = 150 })
saturn:setRadius(6.0268e4)
saturn:setOrbitalRadius(1.433e9)
saturn:setOrbitalPeriod(1.0759e4 * SECONDS_PER_DAY)
saturn:setCenter(CENTER)

uranus = Spob:new() -- Uranus
uranus:setName("Uranus")
uranus:setColor({ R = 200, G = 250, B = 220 })
uranus:setRadius(2.5559e4)
uranus:setOrbitalRadius(2.7489e9)
uranus:setOrbitalPeriod(2.0799e4 * SECONDS_PER_DAY)
uranus:setCenter(CENTER)

neptune = Spob:new() -- Neptune
neptune:setName("Neptune")
neptune:setColor({ R = 150, G = 150, B = 250 })
neptune:setRadius(2.4764e4)
neptune:setOrbitalRadius(4.4529e9)
neptune:setOrbitalPeriod(6.0190e4 * SECONDS_PER_DAY)
neptune:setCenter(CENTER)

return { mercury, venus, earth, mars, jupiter, saturn, uranus, neptune }
