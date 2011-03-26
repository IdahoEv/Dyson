require 'secs'

ZOOM_FACTOR   = 1.5
INITIAL_SCALE = 1.5e9  -- kilometers per screen HEIGHT

ScreenScale = class:new()
ScreenScale.screen_scale = INITIAL_SCALE

function ScreenScale:init()
  self:detectScreenSize()
  -- view center starts as nil (i.e., origin)
  self.view_center = nil
end

-- x, y in kilometers relative to the origin, which is assumed at screen center
function ScreenScale:screenCoords(x, y)
   -- Compute offsets if the view center is some spob
   if self.view_center == nil then
      px, py = 0, 0
   else
      px, py = self.view_center:getLocation()
   end
   screen_x = (x-px) * self:pixelScale() + self.screen_center.x
   screen_y = (y-py) * self:pixelScale() + self.screen_center.y

   return screen_x, screen_y
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

function ScreenScale:resetZoom()
   self.screen_scale = INITIAL_SCALE
end

function ScreenScale:detectScreenSize()
  self.screen_width  = love.graphics.getWidth()
  self.screen_height = love.graphics.getHeight()
  self.screen_center = { x = self.screen_width/2,
                         y = self.screen_height/2 }
end




