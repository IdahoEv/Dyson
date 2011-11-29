require 'star'
require 'centroid'
require 'star_names'

STAR_COUNT    = 100
--STAR_COUNT    = 3
STAR_RADIUS   = 6.955e5 -- km
LIGHT_YEAR    = 9.46e12 -- km
DISTANCE_SCALE = 100 -- lightears

MIN_MASS = math.log10(.1)
MAX_MASS = math.log10(80)
MASS_RANGE = MAX_MASS-MIN_MASS

AU = 149598000 -- km
BINARY_PROBABILITY = 1 / 6 -- should make 1/3 of stars binary

STAR_NAMES = require('star_names')
stars = {}

function randomMass()
  factor = math.random() * MASS_RANGE + MIN_MASS
  return 10^factor * SOLAR_MASS
end

function randomLocation()
  return matrix{(math.random() - 0.5) * DISTANCE_SCALE * LIGHT_YEAR,
		(math.random() - 0.5) * DISTANCE_SCALE * LIGHT_YEAR,
		(math.random() - 0.5) * DISTANCE_SCALE * LIGHT_YEAR}
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
  local alpha = randomStar(name..' Alpha')
  local beta = randomStar(name..' Beta')
  -- Alpha should be the more luminous star
  if beta.luminosity > alpha.luminosity then
    alpha, beta = beta, alpha
    alpha.name, beta.name = beta.name, alpha.name
  end
  centroid = Centroid:new(nil)
  centroid.name = name .. ' System'
  centroid.location = randomLocation()
  alpha:setHost(centroid)
  beta:setHost(centroid)
  local diameter = ((math.random() * 99) + 1) * AU
  local total_mass = alpha.mass + beta.mass
  -- Set radii inverse relative to the proportional mass
  -- TODO: See if this is actually correct!
  alpha:setOrbitalRadius(diameter * (beta.mass / total_mass))
  beta:setOrbitalRadius(diameter * (alpha.mass / total_mass))

  -- what units is this in?
  local period = math.sqrt( ((diameter^3) * TAU) / (GRAVITATIONAL_CONSTANT_KM * total_mass))
  alpha:setOrbitalPeriod(period)
  beta:setOrbitalPeriod(period)
  beta.orbital_phase = TAU / 2
  return centroid
end

function randomName()
  return STAR_NAMES[math.floor((math.random() * #STAR_NAMES))]
end

for ii = 1, STAR_COUNT do
  local spob
  if math.random() < BINARY_PROBABILITY then
    spob = randomStar(randomName())
  else
    spob = randomBinary(randomName())
  end
  stars[ii] = spob
end

table.insert(stars, randomBinary('Centauri'))
--stars[STAR_COUNT+1] = centroid

return stars

