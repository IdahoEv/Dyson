require 'middleclass'
local matrix = require 'lua_matrix/lua/matrix'

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
function ScreenScale:screenCoords(location)
  local center_loc = self:viewCenterLocation()
  local screen_loc = (location - center_loc) * self:pixelScale() + self.screen_center

  --local screen_x = (location.x-center_loc.x) * self:pixelScale() + self.screen_center.x
  --local screen_y = (location.y-center_loc.y) * self:pixelScale() + self.screen_center.y

  --return screen_x, screen_y
  return screen_loc[1][1], screen_loc[2][1]
end

function ScreenScale:viewCenterLocation()
  if self.view_center == nil then
    return matrix:new{ 0, 0, 0 }
  else
    return self.view_center:getLocation()
  end
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
  self.screen_center = matrix:new{ 
                         self.screen_width/2,
                         self.screen_height/2,
                         0 }
end




