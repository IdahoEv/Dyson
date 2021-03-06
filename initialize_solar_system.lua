require 'constants'
require 'paintable_disc'
require 'paintable_disc_with_ring'
require 'paintable_image'
require 'paintable_disc'
require 'paintable_star'
require 'paintable_construct'
require 'star'
require 'construct'
local matrix = require 'matrix_utils'

VENUS_ORBIT_RADIUS   = 1.08e8 -- km
EARTH_ORBIT_RADIUS   = 1.49e8 -- km
MARS_ORBIT_RADIUS    = 2.28e8 -- km
JUPITER_ORBIT_RADIUS = 7.8e8  -- km
LUNA_ORBIT_RADIUS    = 3.84e5 -- km, around the Earth

VENUS_RADIUS = 6051.8
MARS_RADIUS  = 3393.0 -- km
EARTH_RADIUS = 6378.0 -- km
LUNA_RADIUS  = 1737.4 -- km

local sol = Star:new(nil, SOLAR_MASS) -- Sol
sol.name = "Sol"
-- sol.paintable = PaintableDisc:new(sol,{ R = 225, G = 225, B = 0 })
sol.paintable = PaintableStar:new(sol, { R = 255, G = 255, B = 225 })
sol:setOrbitalRadius(0)
sol:setOrbitalPeriod(1)

local niven_ring = Construct:new(sol, 
   60, 
   EARTH_ORBIT_RADIUS * 2.5,
   EARTH_ORBIT_RADIUS * .5, -- cylinder height, km
   10,                      -- cylinder thickness, km
   500 * SECONDS_PER_DAY, 
   matrix:new{ .5, .5, 1 }
)
niven_ring.name = "Niven Ring"
niven_ring.paintable = PaintableConstruct:new(niven_ring, { R = 200, G = 100, B = 100 })

local solar_halo = Construct:new(sol, 
   30, 
   VENUS_ORBIT_RADIUS * 0.1,
   VENUS_ORBIT_RADIUS * .01, -- cylinder height, km
   10,                       -- cylinder thickness, km
   10 * SECONDS_PER_DAY, 
   matrix:new{ .5, .5, .25 }
)
solar_halo.name = "Solar Halo"
solar_halo:setOrbitalRadius(1.2*EARTH_ORBIT_RADIUS)
solar_halo:setOrbitalPeriod(410 * SECONDS_PER_DAY)
solar_halo.paintable = PaintableConstruct:new(solar_halo, { R = 100, G = 220, B = 200 })

local kiri = Spob:new(sol) -- kiri
kiri.name = "Kiri"
kiri.paintable = PaintableImage:new(kiri, 'heart.png',
                                  { R = 0x8d, G = 0x34, B = 0x1a })
kiri:setRadius(30000)
kiri:setOrbitalRadius(4e7) -- km
kiri:setOrbitalPeriod(50 * SECONDS_PER_DAY)

local mercury = Sphere:new(sol) -- mercury
mercury.name = "Mercury"
mercury.paintable = PaintableDisc:new(mercury,{ R = 100, G = 100, B = 60 })
mercury:setRadius(2437.9)
mercury:setOrbitalRadius(6.9e7) -- km
mercury:setOrbitalPeriod(87.969 * SECONDS_PER_DAY)

local venus = Sphere:new(sol) -- venus
venus.name = "Venus"
venus.paintable = PaintableDisc:new(venus,{ R = 50, G = 150, B = 200 })
venus:setRadius(VENUS_RADIUS)
venus:setOrbitalRadius(VENUS_ORBIT_RADIUS)
venus:setOrbitalPeriod(224.7 * SECONDS_PER_DAY)

local earth = Sphere:new(sol) -- Earth
earth.name = "Earth"
earth.paintable = PaintableDisc:new(earth,{ R = 50, G = 60, B = 200 })
earth:setRadius(EARTH_RADIUS)
earth:setOrbitalRadius(EARTH_ORBIT_RADIUS)
earth:setOrbitalPeriod(365.25 * SECONDS_PER_DAY)

local luna = Sphere:new(earth) -- Luna
luna.name = "Luna"
luna.paintable = PaintableDisc:new(luna,{ R = 200, G = 200, B = 230 })
luna:setRadius(LUNA_RADIUS)
luna:setOrbitalRadius(LUNA_ORBIT_RADIUS)
luna:setOrbitalPeriod(27.3 * SECONDS_PER_DAY)

local ring = Construct:new(earth, 12, EARTH_RADIUS*4, 14000, 10, SECONDS_PER_DAY, matrix:new{ 0.2, 0.2, 1})
ring.name = "Square"
ring.paintable = PaintableConstruct:new(ring, { R = 200, G = 200, B = 200 })

local mars = Sphere:new(sol) -- Mars
mars.name = "Mars"
--mars.paintable = PaintableDisc:new(mars,{ R = 0x8d, G = 0x34, B = 0x1a })
mars.paintable = PaintableImage:new(mars, 'mars.png',
                                  { R = 0x8d, G = 0x34, B = 0x1a })
mars:setRadius(MARS_RADIUS)
mars:setOrbitalRadius(MARS_ORBIT_RADIUS)
mars:setOrbitalPeriod(686 * SECONDS_PER_DAY)

local phobos = Sphere:new(mars) -- Phobos
phobos.name = "Phobos"
phobos.paintable = PaintableDisc:new(phobos,{ R = 0x9a, G = 0x8e, B = 0x85 })
phobos:setRadius(11.1)
phobos:setOrbitalRadius(9377)
phobos:setOrbitalPeriod(0.319 * SECONDS_PER_DAY)

local deimos = Sphere:new(mars) -- Deimos
deimos.name = "Deimos"
deimos.paintable = PaintableDisc:new(deimos,{ R = 0xc9, G = 0xb5, B = 0x9a })
deimos:setRadius(6.2)
deimos:setOrbitalRadius(23460)
deimos:setOrbitalPeriod(1.262 * SECONDS_PER_DAY)

local jupiter = Sphere:new(sol) -- Jupiter
jupiter.name = "Jupiter"
--jupiter.paintable = PaintableDisc:new(jupiter,{ R = 250, G = 100, B = 100 })
jupiter.paintable = PaintableDiscWithRing:new(jupiter,{ R = 250, G = 100, B = 100 })
jupiter:setRadius(7.149e4)
jupiter:setOrbitalRadius(7.785e8)
jupiter:setOrbitalPeriod(4331.6 * SECONDS_PER_DAY)

local io = Sphere:new(jupiter)
io.name = "Io"
io.paintable = PaintableDisc:new(io,{ R = 0xf3, G = 0xe8, B = 0x84 })
io:setRadius(1821.3)
io:setOrbitalRadius(421700)
io:setOrbitalPeriod(1.769 * SECONDS_PER_DAY)

local europa = Sphere:new(jupiter)
europa.name = "Europa"
europa.paintable = PaintableDisc:new(europa,{ R = 0xab, G = 0x96, B = 0x76 })
europa:setRadius(1569)
europa:setOrbitalRadius(670900)
europa:setOrbitalPeriod(3.551 * SECONDS_PER_DAY)

local ganymede = Sphere:new(jupiter)
ganymede.name = "Ganymede"
ganymede.paintable = PaintableDisc:new(ganymede,{ R = 0x9d, G = 0x86, B = 0x86 })
ganymede:setRadius(2634)
ganymede:setOrbitalRadius(1.070e6)
ganymede:setOrbitalPeriod(7.155 * SECONDS_PER_DAY)

local callisto = Sphere:new(jupiter)
callisto.name = "Callisto"
callisto.paintable = PaintableDisc:new(callisto,{ R = 0x5c, G = 0x52, B = 0x36 })
callisto:setRadius(2410)
callisto:setOrbitalRadius(1.8827e6)
callisto:setOrbitalPeriod(16.689 * SECONDS_PER_DAY)

local saturn = Sphere:new(sol) -- Saturn
saturn.name = "Saturn"
saturn.paintable = PaintableDisc:new(saturn,{ R = 200, G = 200, B = 150 })
saturn:setRadius(6.0268e4)
saturn:setOrbitalRadius(1.433e9)
saturn:setOrbitalPeriod(1.0759e4 * SECONDS_PER_DAY)

local titan = Sphere:new(saturn)
titan.name = "Titan"
titan.paintable = PaintableDisc:new(titan,{ R = 0xf9, G = 0xd2, B = 0x52 })
titan:setRadius(2576)
titan:setOrbitalRadius(1.221e6)
titan:setOrbitalPeriod(15.945 * SECONDS_PER_DAY)

local uranus = Sphere:new(sol) -- Uranus
uranus.name = "Uranus"
uranus.paintable = PaintableDisc:new(uranus,{ R = 200, G = 250, B = 220 })
uranus:setRadius(2.5559e4)
uranus:setOrbitalRadius(2.7489e9)
uranus:setOrbitalPeriod(2.0799e4 * SECONDS_PER_DAY)

local neptune = Sphere:new(sol) -- Neptune
neptune.name = "Neptune"
neptune.paintable = PaintableDisc:new(neptune,{ R = 150, G = 150, B = 250 })
neptune:setRadius(2.4764e4)
neptune:setOrbitalRadius(4.4529e9)
neptune:setOrbitalPeriod(6.0190e4 * SECONDS_PER_DAY)

local triton = Sphere:new(neptune)
triton.name = "Triton"
triton.paintable = PaintableDisc:new(triton,{ R = 0xa7, G = 0xb2, B = 0xb9 })
triton:setRadius(1353)
triton:setOrbitalRadius(354759)
-- Triton is retrograde
triton:setOrbitalPeriod(-5.877 * SECONDS_PER_DAY)

-- Return only the top-level planets, enabling easy access
-- via shift-number hotkeys.  Everything else is global anyway,
-- so we still have access to them in namespace.
return sol
-- return { mercury, venus, earth, mars, jupiter, saturn, uranus, neptune }
