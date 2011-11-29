require "middleclass" -- definition of useful class construction methods
require "paintable"
local matrix = require 'lua-matrix/lua/matrix'

PaintableConstruct = Paintable:subclass('PaintableConstruct')

function PaintableConstruct:initialize(spob, color)
  self.spob  = spob
  self.color = color
end

function PaintableConstruct:draw()
  local segments = self.spob.segments

  love.graphics.setColor(self.color.R, self.color.G, self.color.B)

  local construct_location = self.spob:getLocation()
  for seg_i, segment in pairs(self.spob.segments) do
    for face_i, face in pairs(segment.faces) do
      polygon = {}
      for _, point in pairs(face) do
	local theta = self.spob.rotation_angle
	local sin_theta = math.sin(theta)
	local cos_theta = math.cos(theta)
	-- This is a 3D rotation matrix around the z axis
	local rot_p = matrix{{cos_theta,-sin_theta,0},
			     {sin_theta, cos_theta,0},
			     {        0,         0,1}} * point    
	local p = rot_p + construct_location -- yummy, I'm a matrix
        local screen_x, screen_y = scale:screenCoords(p)
        table.insert(polygon, screen_x)
        table.insert(polygon, screen_y)
      end
      -- Need line mode to be able to see edge-on polygons!
      love.graphics.polygon("line", polygon)      
      love.graphics.polygon("fill", polygon)      
    end    
  end

end

