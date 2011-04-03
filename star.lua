require "middleclass" -- definition of useful class construction methods
require 'constants'
require "spob"

Star = Spob:subclass('Star')


function Star:initialize(host, mass)
  Spob.initialize(self, host)
  self.mass         = mass -- kg
  self.temperature  = 0    -- K
  self.luminosity   = (self.mass / SOLAR_MASS)^MAIN_SEQUENCE_CONSTANT * SOLAR_LUMINOSITY
  print(string.format("Star with %.2f solar masses and luminosity %.2e", (self.mass / SOLAR_MASS), (self.luminosity / SOLAR_LUMINOSITY)))
end