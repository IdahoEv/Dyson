require 'star'
require 'centroid'

STAR_COUNT    = 100
--STAR_COUNT    = 3
STAR_RADIUS   = 6.955e5 -- km
LIGHT_YEAR    = 9.46e12 -- km
DISTANCE_SCALE = 100 -- lightears

MIN_MASS = math.log10(.1)
MAX_MASS = math.log10(80)
MASS_RANGE = MAX_MASS-MIN_MASS

BINARY_ORBIT = 1495980000 -- km, = 10AU

stars = {}

function randomMass()
  factor = math.random() * MASS_RANGE + MIN_MASS
  return 10^factor * SOLAR_MASS
end

function randomLocation()
  return {
    x = (math.random() - 0.5) * DISTANCE_SCALE * LIGHT_YEAR,
    y = (math.random() - 0.5) * DISTANCE_SCALE * LIGHT_YEAR,
    z = (math.random() - 0.5) * DISTANCE_SCALE * LIGHT_YEAR
  }
end

function randomStar(name)
  local star = Star:new(nil, randomMass())
  -- sol.paintable = PaintableDisc:new(sol,{ R = 225, G = 225, B = 0 })
  star.paintable = PaintableStar:new(star, 'yellow', { R = 225, G = 225, B = 225 })
  star.name = name
  star:setOrbitalRadius(0)
  star:setOrbitalPeriod(1)
  star.location = randomLocation()
  return star
end

function randomBinary(name)
  alpha = randomStar(name..' Alpha')
  beta = randomStar(name..' Beta')
  centroid = Centroid:new(nil)
  centroid.name = name .. ' System'
  centroid.location = randomLocation()
  alpha:setHost(centroid)
  beta:setHost(centroid)
  alpha:setOrbitalRadius(BINARY_ORBIT * 2 /3)
  beta:setOrbitalRadius(BINARY_ORBIT / 3)
  alpha:setOrbitalPeriod(70 * SECONDS_PER_DAY)
  beta:setOrbitalPeriod(70 * SECONDS_PER_DAY)
  beta.orbital_phase = TAU / 2
  return centroid
end

for ii = 1, STAR_COUNT do
  local star = randomStar("Star #"..ii)
  stars[ii] = star
end


-- -- Create a binary star by taking the first two stars above and
-- -- making them orbit a common center
-- centroid = Spob:new(nil)
-- centroid.name = "Centroid #1"
-- star_ind1 = 2
-- star_ind2 = 3
-- print(centroid.host)
-- centroid.location = {
--   x = (stars[star_ind1].location.x + stars[star_ind2].location.x) / 2,
--   y = (stars[star_ind1].location.y + stars[star_ind2].location.y) / 2,
--   z = (stars[star_ind1].location.z + stars[star_ind2].location.z) / 2 }
-- stars[star_ind1].host = centroid
-- stars[star_ind2].host = centroid
-- stars[star_ind1]:setOrbitalRadius(3e13)
-- stars[star_ind2]:setOrbitalRadius(5e13)
-- stars[star_ind1]:setOrbitalPeriod(70 * SECONDS_PER_DAY)
-- stars[star_ind2]:setOrbitalPeriod(70 * SECONDS_PER_DAY)
-- stars[star_ind2].orbital_phase = TAU / 2

table.insert(stars, randomBinary('Centauri'))
--stars[STAR_COUNT+1] = centroid

return stars

