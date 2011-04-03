require "middleclass" -- definition of useful class construction methods
require "paintable"

PaintableStar = Paintable:subclass('PaintableStar')

function PaintableStar:initialize(spob, colorname, color)
  self.spob  = spob
  self.colorname = colorname
  self.image = love.graphics.newImage(string.format("images/star_%s.png", colorname))
  self.half_width = self.image:getWidth() / 2
  self.half_height = self.image:getHeight() / 2
  self.color = color
end

function PaintableStar:draw()
  local scale_factor = self.radius * 100 / self.image:getWidth()
  if self.color then
    love.graphics.setColor(self.color.R, self.color.G, self.color.B)
  else
    love.graphics.setColor(255, 255, 255)
  end
  love.graphics.draw(self.image,
    self.x - (self.half_width * scale_factor),
    self.y - (self.half_height * scale_factor),
    0,
    scale_factor,
    scale_factor
  )
end
