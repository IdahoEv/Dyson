require "middleclass" -- definition of useful class construction methods
require "paintable"

PaintableImage = Paintable:subclass('PaintableImage')

function PaintableImage:initialize(spob, imagefile, color)
  self.spob  = spob
  self.image = love.graphics.newImage(string.format("images/%s",imagefile))
  self.half_width = self.image:getWidth() / 2
  self.half_height = self.image:getHeight() / 2
  self.color = color
end

function PaintableImage:draw()
  local scale_factor = self.radius / self.image:getWidth()
  -- Reset color to white, 
  -- since otherwise the image gets tinted with the current color
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.image,
    self.x - (self.half_width * scale_factor),
    self.y - (self.half_height * scale_factor),
    0,
    scale_factor,
    scale_factor
  )
end
