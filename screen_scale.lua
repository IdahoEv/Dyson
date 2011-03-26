require 'middleclass'

KEYBOARD_ZOOM_FACTOR = 1.5
MOUSE_ZOOM_FACTOR    = 1.2

ScreenScale = class('ScreenScale')
ScreenScale.screen_scale = 1.5e9     -- kilometers per screen HEIGHT

function ScreenScale:initialize()
  self:detectScreenSize()
  -- view center starts as nil (i.e., origin)
  self.view_center = nil
end

-- x, y in kilometers relative to the origin, which is assumed at screen center
function ScreenScale:screenCoords(x, y)
   -- Compute offsets if the view center is some spob
   if self.view_center == nil then
      px = 0
      py = 0
   else
      px = self.view_center.location.x
      py = self.view_center.location.y
   end
   screenx = (x-px) * self:pixelScale() + self.screen_center.x
   screeny = (y-py) * self:pixelScale() + self.screen_center.y

   return screenx, screeny
end

-- pixels per kilometer
function ScreenScale:pixelScale()
  return self.screen_height / self.screen_scale
end

function ScreenScale:zoomIn(factor)
  self.screen_scale = self.screen_scale / factor
end

function ScreenScale:zoomOut(factor)
  self.screen_scale = self.screen_scale * factor
end

function ScreenScale:detectScreenSize()
  self.screen_width = love.graphics.getWidth()
  self.screen_height = love.graphics.getHeight()
  self.screen_center = { x = self.screen_width/2,
                         y = self.screen_height/2 }
end





