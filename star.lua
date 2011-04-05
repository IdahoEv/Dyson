require "middleclass" -- definition of useful class construction methods
require 'constants'
require "spob"

Star = Spob:subclass('Star')


function Star:initialize(host, mass)
  Spob.initialize(self, host)
  self.mass           = mass -- kg
  self.temperature    = 0    -- K
  self.luminosity     = (self.mass / SOLAR_MASS)^MAIN_SEQUENCE_CONSTANT * SOLAR_LUMINOSITY
  self.stellar_class  = self:findClass()
  self.radius         = (self.mass / SOLAR_MASS) ^ 0.8 * SOLAR_RADIUS
  print(string.format("Class %s star with %.2f solar masses, luminosity %.2e, and radius %.2e kM",
    self.stellar_class,
    (self.mass / SOLAR_MASS),
    (self.luminosity / SOLAR_LUMINOSITY),
    self.radius
  ))
end

function Star:findClass()
  solar_masses = self.mass / SOLAR_MASS
  if      solar_masses >= 20 then
    return "O"
  elseif  solar_masses >= 4 then
    return "B"
  elseif  solar_masses >= 2 then
    return "A"
  elseif  solar_masses >= 1.05 then
    return "F"
  elseif  solar_masses >= 0.8 then
    return "G"
  elseif  solar_masses >= 0.5 then
    return "K"
  elseif  solar_masses >= 0.08 then
    return "M"
  end
end

function Star:getAttribs()
  local a = { Stellar_class = self.stellar_class,
              Mass = self.mass,
              Temp = self.temperature,
              Luminosity = self.luminosity,
              Radius = self.radius }
  if (self.host) then
    a['Host'] = self.host.name
    a['Orbital_radius'] = self.orbital_radius
    a['Orbital_period'] = self.orbital_period
  end
  return a
end


