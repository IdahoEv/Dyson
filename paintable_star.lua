require "middleclass" -- definition of useful class construction methods
require "paintable"

PaintableStar = Paintable:subclass('PaintableStar')

function PaintableStar:initialize(spob, color)
  self.spob  = spob
  self.color = color
  self.image = love.graphics.newImage("star_"..color..".png")
  self.half_width = self.image:getWidth() / 2
  self.half_height = self.image:getHeight() / 2
end

function PaintableStar:draw()
  local scale_factor = self.radius * 100 / self.image:getWidth()
  love.graphics.draw(self.image,
    self.x - (self.half_width * scale_factor),
    self.y - (self.half_height * scale_factor),
    0,
    scale_factor,
    scale_factor
  )
end
