require "secs" -- definition of useful class construction methods

Spob = class:new()

-- Name: default = ""
Spob.name = ""
-- Color: default = white
Spob.color = { R = 255, G = 255, B = 255 }
-- Size
Spob.radius = 10
-- Number of segments to use when drawing the circle
Spob.segments = 50
-- Location: absolute.  With respect to what?  Center of "universe"?
Spob.loc = { x = 100, y = 100, z = 0 }
-- Center: absolute coords for what this spob orbits
Spob.center = { x = 0, y = 0, z = 0 }
Spob.speed = 3 -- ultimately make this period instead, probably
Spob.orbital_radius = 100

-- Set the color, assuming it comes in as a table with R, G, B defined
function Spob:setColor(c)
   -- Ignore incorrectly specified colors
   if (c.R ~= nil and c.G ~= nil and c.B ~= nil) then
      self.color = c
   end
end

function Spob:setName(n)
   self.name = n
end

function Spob:setRadius(r)
   self.radius = r
end

-- Center c should be a table with x, y, and z values
function Spob:setCenter(c)
   self.center = c
end

function Spob:setSpeed(s)
   self.speed = s
end

function Spob:setOrbitalRadius(r)
   self.orbital_radius = r
end

-- Draw the object at time t
function Spob:draw(t, scale)
   love.graphics.setColor(self.color.R, self.color.G, self.color.B)
   ox, oy = Spob:orbitCoords(t, self.speed, self.orbital_radius, self.center)
   x, y = scale:screenCoords(ox, oy)
   love.graphics.circle("fill", x, y, self.radius, self.segments)
   love.graphics.print(self.name, x+12, y-5);
end

function Spob:orbitCoords(ndraws, speed, radius)
  x = (math.sin(ndraws * speed / radius) * radius)
  y = (math.cos(ndraws * speed / radius) * radius)
  return x, y
end
