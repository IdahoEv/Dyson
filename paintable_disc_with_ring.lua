require "middleclass" -- definition of useful class construction methods
require "paintable_disc"

PaintableDiscWithRing = PaintableDisc:subclass('PaintableDiscWithRing')

function PaintableDiscWithRing:draw()

  if preferences.enlarge_planets and self.spob.name ~= "Sol" then
     self.radius = self.radius * PLANET_RADIUS_ZOOM
  end
  love.graphics.setColor(200, 200, 200)
  local ls = love.graphics.getLineStipple()
  love.graphics.setLineStipple(0x3f07)
  love.graphics.circle("line", self.x, self.y, self.radius*1.20, 100)
  love.graphics.circle("line", self.x, self.y, self.radius*1.23, 100)
  love.graphics.circle("line", self.x, self.y, self.radius*1.25, 100)
  love.graphics.setLineStipple(0xffff )
  
  love.graphics.setColor(self.color.R, self.color.G, self.color.B)
  love.graphics.circle("fill", self.x, self.y, math.max(self.radius, 1), 100)
end
