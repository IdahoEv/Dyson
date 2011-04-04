require "middleclass" -- definition of useful class construction methods
require "paintable"

PaintableStar = Paintable:subclass('PaintableStar')
PaintableStar.defaultImage = love.graphics.newImage("images/star_white.png")

function PaintableStar:initialize(spob, color)
  self.spob  = spob
  self.colorname = colorname
  self.image = PaintableStar.defaultImage
  self.half_width = self.image:getWidth() / 2
  self.half_height = self.image:getHeight() / 2
  self.color = color
end

function PaintableStar:draw()
  local scale_factor = self.radius * 100 / self.image:getWidth()
  if self.color and self.color.R then
    love.graphics.setColor(self.color.R, self.color.G, self.color.B)
  else
    love.graphics.setColor(255, 255, 255)
  end

  -- If the image would be drawn smaller than 7 pixels, draw a simple disc instead.
  if (self.image:getWidth() * scale_factor) < 7 then
    love.graphics.circle("fill", self.x, self.y, math.max(self.radius, 1), 10)
  else
    love.graphics.draw(self.image,
      self.x - (self.half_width * scale_factor),
      self.y - (self.half_height * scale_factor),
      0,
      scale_factor,
      scale_factor
    )
  end
end
