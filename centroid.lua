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

-- Override isVisible so that if the centroid's two stars
-- are both visible, the centroid itself is not.
function Centroid:isVisible(min_dist, max_dist)
  local dist_from_center  = self:distanceFromPoint(scale:viewCenterLocation())
  local dist_from_host    = self:distanceFromParent()
  if (dist_from_center < max_dist) and
    ((self.host == nil) or (dist_from_host > min_dist)) then
    -- If any are not visible, return true
    for _, sat in ipairs(self.satellites) do
      if sat:isVisible(min_dist, max_dist) == false then return true end
    end
    -- All satellites are visible, so omit centroid
    return false
  end
  -- Centroid isn't within the view screen
  return false
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
