require "middleclass" -- definition of useful class construction methods
require 'constants'
require "spob"

Centroid = Spob:subclass('Centroid')

function Centroid:initialize(host, mass)
  Spob.initialize(self, host)

  -- a bare paintable just shows the name
  self.paintable = Paintable:new(self)
end

function Centroid:draw(scale)
  -- print('Drawing centroid', self.name)
  Spob.draw(self, scale)
end

function Centroid:addSatellite(other_spob)
  Spob.addSatellite(self, other_spob)
  self.mass = 0
  for _, spob in ipairs(self.satellites) do
    self.mass = self.mass + spob.mass
  end
end

-- Return a table containing attributes we'd like to display
-- in the Inspector
function Centroid:getAttribs()
  return { } 
  -- Host = self.host.name,
  --          Radius = self.radius,
  --          Orbital_radius = self.orbital_radius,
  --          Period = self.orbital_period }
end
