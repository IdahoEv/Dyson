require "middleclass" -- definition of useful class construction methods
require 'constants'

Spob = class('Spob')

-- Name: default = ""
function Spob:initialize(host)

  -- Host: body around which this Spob orbits (parent)
  self.host = host
  if self.host ~= nil then
    self.host:addSatellite(self)
  end

  self.name = ""
  -- Size (in km)
  self.radius = 10
  -- Number of segments to use when drawing the circle
  self.segments = 50
  -- Location: relative to parent body (in km)
  self.location = { x = 0, y = 0, z = 0 }
  -- Satellites: bodies that orbit this Spob (children)
  self.satellites = { }

  self.orbital_radius = 0 -- in kilometers
  self.orbital_period = 0 -- in seconds
  self.paintable = nil
end


function Spob:addSatellite(other_spob)
  table.insert(self.satellites, other_spob)
end

function Spob:setRadius(r)
   -- Ignore nonpositive radii
   if (r > 0) then
      self.radius = r
   end
end

function Spob:setOrbitalPeriod(s)
  self.orbital_period = s
end

function Spob:setOrbitalRadius(r)
   -- Ignore nonpositive radii
   if (r > 0) then
      self.orbital_radius = r
   end
end

-- Draw the object in the current location
function Spob:draw(scale)
  -- If it has a host, then (optionally) draw its orbit around that host
  if self.host ~= nil and preferences.show_orbits then
    self:drawOrbit(self.host:getLocation())
  end

  -- Draw self, if visible (e.g. Centroids are not)
  if (self.paintable) then self.paintable:paint(self:getLocation()) end
end

-- Return the (absolute) x,y coordinates of this Spob
function Spob:getLocation()
   local host_x, host_y, host_z
   -- If no host, location is relative to screen center
   if (self.host == nil) then
      host_loc = { x = 0, y = 0, z = 0 }
   else
      -- recurse!
      host_loc = self.host:getLocation()
    end
    -- print(self.name, host_loc.x, host_loc.y)
   return { x = self.location.x + host_loc.x,
            y = self.location.y + host_loc.y,
            z = self.location.z + host_loc.z }
end

function Spob:drawOrbit(host_loc)
  local orbital_radius = self.orbital_radius * scale:pixelScale()
  if orbital_radius > 10 then
    local segments = math.pi / ( math.acos(1-(MAX_ORBIT_CIRCLE_ERROR/orbital_radius)))
    love.graphics.setColor(40, 40, 40)
    local hx, hy = scale:screenCoords(host_loc)
    love.graphics.circle('line', hx, hy, orbital_radius, segments)
  end
end

function Spob:distanceFromParent()
  return math.sqrt(
    (self.location.x * self.location.x) +
    (self.location.y * self.location.y)
    -- + (self.location.z * self.location.z)
  )
end

function Spob:distanceFromPoint(point)
  local loc = self:getLocation()
  local dx = loc.x - point.x
  local dy = loc.y - point.y
  local dz = loc.z - point.z
  return math.sqrt(dx * dx + dy * dy) -- + dz * dz)
end

-- Update the current position of this spob relative to its parent body
-- Time since arbitrary time 0, in seconds
function Spob:updateCoords(time)
  if self.host then
    local theta = TAU * (time / self.orbital_period)
    self.location.x = math.sin(theta) * self.orbital_radius
    self.location.y = math.cos(theta) * self.orbital_radius
  end
  -- self.location.z is unchanged... since we don't (yet) have
  -- orbital inclination
  if #(self.satellites) > 0 then
    for _, spob in ipairs(self.satellites) do spob:updateCoords(time) end
  end
end

-- Recursively print this spob and its satellites
function Spob:printHierarchy(indent)
  if indent == nil then indent = "" end
  print(string.format("%s%s", indent, self.name))
  if (self.satellites ~= nil) then
    -- indent and recurse
    for _, sat in ipairs(self.satellites) do
      sat:printHierarchy(indent .. "  ")
    end
  end
end

-- Return a table containing attributes we'd like to display
-- in the Inspector
function Spob:getAttribs()
  return { Host = self.host.name,
           Radius = self.radius,
           Orbital_radius = self.orbital_radius,
           Period = self.orbital_period }
end

-- Avoid problems created by doing print(spob) 
function Spob:__tostring()
  return self.name
end
