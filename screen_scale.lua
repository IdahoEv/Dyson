require 'middleclass'

KEYBOARD_ZOOM_FACTOR = 1.5
MOUSE_ZOOM_FACTOR    = 1.2
INITIAL_SCALE = 1.5e9  -- kilometers per screen HEIGHT

ScreenScale = class('ScreenScale')
ScreenScale.screen_scale = INITIAL_SCALE

function ScreenScale:initialize()
  self:detectScreenSize()
  -- view center starts as nil (i.e., origin)
  self.view_center = nil
end

-- x, y in kilometers relative to the origin, which is assumed at screen center
function ScreenScale:screenCoords(x, y)
   local px, py, pz
   -- Compute offsets if the view center is some spob
   if self.view_center == nil then
      px, py, pz = 0, 0
   else
      px, py, pz = self.view_center:getLocation()
   end
   local screen_x = (x-px) * self:pixelScale() + self.screen_center.x
   local screen_y = (y-py) * self:pixelScale() + self.screen_center.y

   return screen_x, screen_y
end

function ScreenScale:screenDist(dist)
  return self:pixelScale() * dist
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

function ScreenScale:resetZoom()
   self.screen_scale = INITIAL_SCALE
end

function ScreenScale:detectScreenSize()
  self.screen_width  = love.graphics.getWidth()
  self.screen_height = love.graphics.getHeight()
  self.screen_center = { x = self.screen_width/2,
                         y = self.screen_height/2 }
end




