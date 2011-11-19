require "middleclass" -- definition of useful class construction methods
require 'constants'
require 'spob'

Sphere = Spob:subclass('Sphere')

-- Name: default = ""
function Sphere:initialize(host)
  Spob.initialize(self, host)

  -- Size (in km)
  self.radius = 10
  -- Number of segments to use when drawing the circle
  self.segments = 50
end

-- Return a table containing attributes we'd like to display
-- in the Inspector
function Sphere:getAttribs()
  return { Host = self.host.name,
           Radius = self.radius,
           Orbital_radius = self.orbital_radius,
           Period = self.orbital_period }
end


