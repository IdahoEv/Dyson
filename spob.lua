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
   local x, y = self:getCoords(scale)
   -- If it has a host, then (optionally) draw its orbit around that host
   if self.host ~= nil and preferences.show_orbits then 
      local host_x, host_y = self.host:getLocation()
      self:drawOrbit(host_x, host_y) 
   end
   
   --print("drawing:", self.name, x, y, self.radius,
   --scale:pixelScale(), self.radius*scale:pixelScale())
   local radius = self.radius * scale:pixelScale()
   if preferences.enlarge_planets and self.name ~= "Sol" then
      radius = radius * PLANET_RADIUS_ZOOM
   end
   love.graphics.setColor(self.color.R, self.color.G, self.color.B)
   love.graphics.circle("fill", x, y, radius, self.segments)
   if preferences.show_reticle then self:drawReticle(x,y,radius) end
   love.graphics.print(self.name, x+radius+4, y - 14 );
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

-- Return the screen (pixel) coordinates of this Spob
function Spob:getCoords(scale)
   local x, y = self:getLocation()
   local screen_x, screen_y = scale:screenCoords(x, y)
   return screen_x, screen_y
end

function Spob:drawOrbit(host_x, host_y)
  local orbital_radius = self.orbital_radius * scale:pixelScale()
  if orbital_radius > 10 then
    love.graphics.setColor(40, 40, 40)
    local hx, hy = scale:screenCoords(host_x, host_y)
    love.graphics.circle('line', hx, hy, orbital_radius, 100)
  end
end

function Spob:drawReticle(x,y,radius)
  love.graphics.line(x+radius+RETICLE_SPACING, y, 
		     x+radius+RETICLE_SPACING+RETICLE_LENGTH, y )
  love.graphics.line(x-radius-RETICLE_SPACING, y, 
		     x-radius-RETICLE_SPACING-RETICLE_LENGTH, y )
  love.graphics.line(x, y+radius+RETICLE_SPACING, x, 
		     y+radius+RETICLE_SPACING+RETICLE_LENGTH )
  love.graphics.line(x, y-radius-RETICLE_SPACING, x, 
		     y-radius-RETICLE_SPACING-RETICLE_LENGTH )
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

