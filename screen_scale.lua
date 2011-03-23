require 'secs'

ZOOM_FACTOR = 1.5

ScreenScale = class:new()
ScreenScale.screen_scale = 1.5e9     -- kilometers per screen HEIGHT

function ScreenScale:init()
  self:detectScreenSize()
end

-- x, y in kilometers relative to the origin, which is assumed at screen center
function ScreenScale:screenCoords(x, y)
  return (x * self:pixelScale() + self.screen_center.x),
         (y * self:pixelScale() + self.screen_center.y)
end

-- pixels per kilometer
function ScreenScale:pixelScale()
  return self.screen_height / self.screen_scale
end

function ScreenScale:zoomIn()
  self.screen_scale = self.screen_scale / ZOOM_FACTOR
end

function ScreenScale:zoomOut()
  self.screen_scale = self.screen_scale * ZOOM_FACTOR
end

function ScreenScale:detectScreenSize()
  self.screen_width = love.graphics.getWidth()
  self.screen_height = love.graphics.getHeight()
  self.screen_center = { x = self.screen_width/2,
                         y = self.screen_height/2 }
end





