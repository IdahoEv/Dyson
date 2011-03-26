require "middleclass" -- definition of useful class construction methods
require "paintable"

PaintableDisc = Paintable:subclass('PaintableDisc')

function PaintableDisc:initialize(spob, color)
  self.spob  = spob
  self.color = color
end

function PaintableDisc:draw()

  if preferences.enlarge_planets and spob.name ~= "Sol" then
     self.radius = self.radius * PLANET_RADIUS_ZOOM
  end
  love.graphics.setColor(self.color.R, self.color.G, self.color.B)
  love.graphics.circle("fill", self.x, self.y, self.radius, 100)
end
