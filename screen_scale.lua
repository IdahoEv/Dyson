require 'secs'

ScreenScale = class:new()
if love then
  ScreenScale.screen_width = love.graphics.getWidth()
  ScreenScale.screen_height = love.graphics.getHeight()
else
  ScreenScale.screen_width = 500
  ScreenScale.screen_height = 500
end
ScreenScale.screen_center = { x = ScreenScale.screen_width/2, y = ScreenScale.screen_height/2}
ScreenScale.screen_scale = 1.5e9     -- kilometers per screen width
-- ScreenScale.radius_scale = 1e12   -- kilometers per screen width


-- x, y in kilometers relative to the origin, which is assumed at screen center
function ScreenScale:screenCoords(x, y)
  return (x * self:pixelScale() + self.screen_center.x), (y * self:pixelScale() + self.screen_center.y)
end

-- pixels per kilometer
function ScreenScale:pixelScale()
  return self.screen_width / self.screen_scale
end






