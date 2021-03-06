require "middleclass" -- definition of useful class construction methods
require 'constants'
local matrix = require 'matrix_utils'

Spob = class('Spob')

-- Name: default = ""
function Spob:initialize(host)
  self:setHost(host)

  self.name = ""
  -- Location: relative to parent body (in km)
  self.location = matrix:new{ 0, 0, 0 }
  -- Satellites: bodies that orbit this Spob (children)
  self.satellites = { }

  self.orbital_radius = 0 -- in kilometers
  self.orbital_period = 1 -- in seconds
  self.orbital_phase  = 0 -- in radians
  self.paintable = nil
end

function Spob:setHost(host)
  -- Host: body around which this Spob orbits (parent)
  self.host = host
  if self.host ~= nil then
    self.host:addSatellite(self)
  end
end

function Spob:getStar()
  if instanceOf(Star, self) then
    return self
  elseif self.host ~= nil then
    return self.host:getStar()
  else 
    return nil
  end
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
      host_loc = matrix:new{ 0, 0, 0 }
   else
      -- recurse!
      host_loc = self.host:getLocation()
    end
   return self.location + host_loc 
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
  return matrix.len(self.location)
end

function Spob:distanceFromPoint(point)
  return matrix.len(self:getLocation() - point)
end

-- Update the current position of this spob relative to its parent body
-- Time since arbitrary time 0, in seconds
function Spob:updateCoords(time)
  if self.host then
    local theta = (TAU * (time / self.orbital_period)) + self.orbital_phase
    self.location = matrix:new{ 
     math.sin(theta) * self.orbital_radius, -- X coord
     math.cos(theta) * self.orbital_radius, -- Y coord
     0   
    }
  end
  -- orbital inclination
  if #(self.satellites) > 0 then
    for _, spob in ipairs(self.satellites) do spob:updateCoords(time) end
  end
end

-- Determine whether this spob is visible, i.e., its current location
-- is more than min_dist and less than max_dist from the view center.
function Spob:isVisible(min_dist, max_dist)
  -- If this Spob *is* the view_center, it's obviously visible.
  if self == scale.view_center then return true end
  -- Otherwise, check the distance constraints
  local dist_from_center  = self:distanceFromPoint(scale:viewCenterLocation())
  local dist_from_host    = self:distanceFromParent()
  if (dist_from_center < max_dist) and
    ((self.host == nil) or (dist_from_host > min_dist)) then
      return true
  end
  return false
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
           Orbital_radius = self.orbital_radius,
           Period = self.orbital_period }
end

-- Return the spob's name instead of "instance of Spob"
function Spob:__tostring()
  return self.name
end

-- For some reason, Lua doesn't automatically call __tostring()
-- on objects being concatenated.  Help it along here in case we
-- concatenate a spob with something else.
function Spob:__concat(obj)
  if instanceOf(Spob, obj) then
    return self .. obj.name
  else
    return self.name .. obj
  end
end
