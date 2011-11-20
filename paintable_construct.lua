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
	local p = { x = point.x + construct_location.x,
		    y = point.y + construct_location.y }
        screen_x, screen_y = scale:screenCoords(p)
        table.insert(polygon, screen_x)
        table.insert(polygon, screen_y)
      end
      love.graphics.polygon("line", polygon)      
    end    
  end

end

