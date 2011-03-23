SECONDS_PER_DAY = 24 * 60 * 60
MARS_ORBIT_RADIUS    = 2.28e8 -- km
EARTH_ORBIT_RADIUS   = 1.49e8 -- km
JUPITER_ORBIT_RADIUS = 7.8e8  -- km
LUNA_ORBIT_RADIUS    = 3.84e5 -- km, around the Earth

MARS_RADIUS  = 3393.0 -- km
EARTH_RADIUS = 6378.0 -- km
LUNA_RADIUS  = 1737.4 -- km

mars = Spob:new() -- Mars
mars.name = "Mars"
mars:setColor({ R = 200, G = 0, B = 0 })
mars:setRadius(MARS_RADIUS)
mars:setOrbitalRadius(MARS_ORBIT_RADIUS)
mars:setOrbitalPeriod(686 * SECONDS_PER_DAY)
mars:setCenter(CENTER)

earth = Spob:new() -- Earth
earth.name = "Earth"
earth:setColor({ R = 50, G = 60, B = 200 })
earth:setRadius(EARTH_RADIUS)
earth:setOrbitalRadius(EARTH_ORBIT_RADIUS)
earth:setOrbitalPeriod(365 * SECONDS_PER_DAY)
earth:setCenter(CENTER)

luna = Spob:new() -- Luna
luna.name = "Luna"
luna:setColor({ R = 200, G = 200, B = 200 })
luna:setRadius(LUNA_RADIUS)
luna:setOrbitalRadius(LUNA_ORBIT_RADIUS)
luna:setOrbitalPeriod(27.3 * SECONDS_PER_DAY)
--luna:setCenter(CENTER)

return { mars = mars , earth = earth , luna = luna }
