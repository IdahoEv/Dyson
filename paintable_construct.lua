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

  construct_location = spob.getLocation()
  for seg_i, seg in pairs(segments) do
    for face_i, face in pairs(segment.faces) do
      polygon = {}
      for _, point in face do
        screen_x, screen_y = scale:screenCoords(point)
        table.insert(polygon, screen_x)
        table.insert(polygon, screen_y)
      end
      love.graphics.polygon("fill", polygon)      
    end    
  end

end

