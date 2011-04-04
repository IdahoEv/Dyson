require "middleclass" -- definition of useful class construction methods

Paintable = class('paintable')

function Paintable:initialize(spob)
  self.spob  = spob
end

function Paintable:paint(x, y)
  self.x, self.y  = scale:screenCoords(x, y)
  self.radius     = self.spob.radius * scale:pixelScale()
  self:draw()

  if self.color and self.color.R then
    love.graphics.setColor(self.color.R, self.color.G, self.color.B)
  end

  if preferences.show_reticle then self:drawReticle(self.x,self.y,self.radius) end
  love.graphics.print(self.spob.name, self.x+self.radius+4, self.y - 14 );
end

function Paintable:drawReticle(x,y,radius)
  love.graphics.line(x+radius+RETICLE_SPACING, y,
		     x+radius+RETICLE_SPACING+RETICLE_LENGTH, y )
  love.graphics.line(x-radius-RETICLE_SPACING, y,
		     x-radius-RETICLE_SPACING-RETICLE_LENGTH, y )
  love.graphics.line(x, y+radius+RETICLE_SPACING, x,
		     y+radius+RETICLE_SPACING+RETICLE_LENGTH )
  love.graphics.line(x, y-radius-RETICLE_SPACING, x,
		     y-radius-RETICLE_SPACING-RETICLE_LENGTH )
end
