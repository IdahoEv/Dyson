require "secs" -- definition of useful class construction methods

Spob = class:new()

-- Name: default = ""
function Spob:init()
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
   love.graphics.setColor(self.color.R, self.color.G, self.color.B)
   x, y = scale:screenCoords(self.location.x, self.location.y)
   --print("drawing:", self.name, x, y, self.radius, 
	-- scale:pixelScale(), self.radius*scale:pixelScale())
   love.graphics.circle("fill", x, y, 
			self.radius*scale:pixelScale(), 
			self.segments)
   love.graphics.print(self.name, 
		       x+self.radius*scale:pixelScale()+2, 
		       y-self.radius*scale:pixelScale()/2);
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

