require "middleclass" -- definition of useful class construction methods
require 'constants'

Spob = class('Spob')

-- Name: default = ""
function Spob:initialize()
  self.name = ""
  -- Color: default = white
  self.color = { R = 255, G = 255, B = 255 }
  -- Size
  self.radius = 10
  -- Number of segments to use when drawing the circle
  self.segments = 50
  -- Location: absolute.  With respect to what?  Center of "universe"?
  -- Relative to parent body, in my conception.   So a planet's position is relative to its star.
  self.location = { x = 0, y = 0, z = 0 }
  -- Host: body around which this Spob orbits
  self.host = nil

  self.orbital_radius = 0 -- in kilometers
  self.orbital_period = 0 -- in seconds
  self.paintable = nil
end

-- Set the color, assuming it comes in as a table with R, G, B defined
function Spob:setColor(c)
   -- Ignore incorrectly specified colors
   if (c.R ~= nil and c.G ~= nil and c.B ~= nil) then
      self.color = c
   end
end

function Spob:setRadius(r)
   -- Ignore nonpositive radii
   if (r > 0) then
      self.radius = r
   end
end

-- Center c should be a table with x, y, and z values
function Spob:setCenter(c)
   self.center = c
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
      local host_x, host_y = self.host:getLocation()
      self:drawOrbit(host_x, host_y)
   end

   self.paintable:paint(self:getLocation())

   --print("drawing:", self.name, x, y, self.radius,
   --scale:pixelScale(), self.radius*scale:pixelScale())
end

-- Return the (absolute) x,y coordinates of this Spob
function Spob:getLocation()
   local host_x, host_y
   -- If no host, location is relative to screen center
   if (self.host == nil) then
      host_x, host_y = 0, 0
   else
      -- recurse!
      host_x, host_y = self.host:getLocation()
   end
   return self.location.x + host_x, self.location.y + host_y
end

function Spob:drawOrbit(host_x, host_y)
  local orbital_radius = self.orbital_radius * scale:pixelScale()
  if orbital_radius > 10 then
    local segments = math.pi / ( math.acos(1-(MAX_ORBIT_CIRCLE_ERROR/orbital_radius)))
    love.graphics.setColor(40, 40, 40)
    local hx, hy = scale:screenCoords(host_x, host_y)
    love.graphics.circle('line', hx, hy, orbital_radius, segments)
  end
end


-- Update the current position of this spob relative to its parent body
-- Time since arbitrary time 0, in seconds
function Spob:updateCoords(time)
  -- print(self.name, self.orbital_radius)
  local theta = TAU * (time / self.orbital_period)
  self.location.x = math.sin(theta) * self.orbital_radius
  self.location.y = math.cos(theta) * self.orbital_radius
  -- print(self.name, self.location.x, self.location.y)
end

