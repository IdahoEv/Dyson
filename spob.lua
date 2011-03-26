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
   -- Ignore nonpositive periods
   if (s > 0) then
      self.orbital_period = s
   end
end

function Spob:setOrbitalRadius(r)
   -- Ignore nonpositive radii
   if (r > 0) then
      self.orbital_radius = r
   end
end

-- Draw the object in the current location
function Spob:draw(scale)
   x, y = self:getCoords(scale)

   if preferences.show_orbits then self:drawOrbit(host_x, host_y) end

   --print("drawing:", self.name, x, y, self.radius,
   --scale:pixelScale(), self.radius*scale:pixelScale())
  radius = self.radius * scale:pixelScale()
  if preferences.enlarge_planets and self.name ~= "Sol" then
    radius = radius * PLANET_RADIUS_ZOOM
  end
  love.graphics.setColor(self.color.R, self.color.G, self.color.B)
  love.graphics.circle("fill", x, y, radius, self.segments)
  if preferences.show_reticle then self:drawReticle(x,y,radius) end
  love.graphics.print(self.name, x+radius+4, y - 14 );

end

function Spob:getCoords(scale)
   -- If no host, location is relative to screen center
   if (self.host == nil) then
      host_x, host_y = 0, 0
   else
      host_x, host_y = self.host.location.x, self.host.location.y
   end
   x, y = scale:screenCoords(self.location.x + host_x, self.location.y + host_y)
   return x, y
end

function Spob:drawOrbit(host_x, host_y)
  orbital_radius = self.orbital_radius * scale:pixelScale()
  if orbital_radius > 10 then
    segments = math.pi / ( math.acos(1-(MAX_ORBIT_CIRCLE_ERROR/orbital_radius)))
    love.graphics.setColor(40, 40, 40)
    hx, hy = scale:screenCoords(host_x, host_y)
    love.graphics.circle('line', hx, hy, orbital_radius, segments)
  end
end

function Spob:drawReticle(x,y,radius)
  love.graphics.line(x+radius+RETICLE_SPACING, y, x+radius+RETICLE_SPACING+RETICLE_LENGTH, y )
  love.graphics.line(x-radius-RETICLE_SPACING, y, x-radius-RETICLE_SPACING-RETICLE_LENGTH, y )
  love.graphics.line(x, y+radius+RETICLE_SPACING, x, y+radius+RETICLE_SPACING+RETICLE_LENGTH )
  love.graphics.line(x, y-radius-RETICLE_SPACING, x, y-radius-RETICLE_SPACING-RETICLE_LENGTH )
end

-- Update the current position of this spob relative to its parent body
-- Time since arbitrary time 0, in seconds
function Spob:updateCoords(time)
  -- print(self.name, self.orbital_radius)
  theta = TAU * (time / self.orbital_period)
  self.location.x = math.sin(theta) * self.orbital_radius
  self.location.y = math.cos(theta) * self.orbital_radius
  -- print(self.name, self.location.x, self.location.y)
end

