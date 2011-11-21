require "middleclass" -- definition of useful class construction methods
require "paintable"

PaintableConstruct = Paintable:subclass('PaintableConstruct')

function PaintableConstruct:initialize(spob, color)
  self.spob  = spob
  self.color = color
end

function PaintableConstruct:draw()
  segments = self.spob.segments

  love.graphics.setColor(self.color.R, self.color.G, self.color.B)

  construct_location = self.spob:getLocation()
  for seg_i, segment in pairs(self.spob.segments) do
    for face_i, face in pairs(segment.faces) do
      polygon = {}
      for _, point in pairs(face) do
	sin_theta = math.sin(self.spob.rotation_angle)
	cos_theta = math.cos(self.spob.rotation_angle)
	local rot_p = { x = point.x * cos_theta - point.y * sin_theta,
			y = point.x * sin_theta + point.y * cos_theta }
	local p = { x = rot_p.x + construct_location.x,
		    y = rot_p.y + construct_location.y }
        screen_x, screen_y = scale:screenCoords(p)
        table.insert(polygon, screen_x)
        table.insert(polygon, screen_y)
      end
      -- Need line mode to be able to see edge-on polygons!
      love.graphics.polygon("line", polygon)      
      love.graphics.polygon("fill", polygon)      
    end    
  end

end

