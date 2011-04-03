require 'star'

STAR_COUNT    = 100
STAR_RADIUS   = 6.955e5 -- km
LIGHT_YEAR    = 9.46e12 -- km
DISTANCE_SCALE = 100 -- lightears

MIN_MASS = math.log10(.1)
MAX_MASS = math.log10(80)
MASS_RANGE = MAX_MASS-MIN_MASS

stars = {}

function randomMass()
  factor = math.random() * MASS_RANGE + MIN_MASS
  return 10^factor * SOLAR_MASS
end

for ii = 1, STAR_COUNT do

  star = Star:new(nil, randomMass())
  star.name = "Star #"..ii
  -- sol.paintable = PaintableDisc:new(sol,{ R = 225, G = 225, B = 0 })
  star.paintable = PaintableStar:new(star, 'yellow', { R = 225, G = 225, B = 225 })
  star:setOrbitalRadius(0)
  star:setOrbitalPeriod(1)
  star.location.x = (math.random() - 0.5) * DISTANCE_SCALE * LIGHT_YEAR
  star.location.y = (math.random() - 0.5) * DISTANCE_SCALE * LIGHT_YEAR
  star.location.z = (math.random() - 0.5) * DISTANCE_SCALE * LIGHT_YEAR
  stars[ii] = star
end


return stars

