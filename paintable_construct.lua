require "middleclass" -- definition of useful class construction methods
require "paintable"

PaintableConstruct = Paintable:subclass('PaintableConstruct')

function PaintableConstruct:initialize(spob, color)
  self.spob  = spob
  self.color = color
end

function PaintableConstruct:draw()
  local segments = self.spob.segments

  
  local construct_location = self.spob:getLocation()
  for seg_i, segment in pairs(self.spob.segments) do
    for face_i, face in pairs(segment.current_faces) do
      polygon = {}
      for _, point in pairs(face) do
        local screen_x, screen_y = scale:screenCoords(point)
        table.insert(polygon, screen_x)
        table.insert(polygon, screen_y)
      end
      -- Need line mode to be able to see edge-on polygons!
        
      love.graphics.setColor(self.color.R, self.color.G, self.color.B)

      love.graphics.polygon("fill", polygon)      
      love.graphics.setColor(self.color.R *.5, self.color.G * .5, self.color.B * .5)
      love.graphics.polygon("line", polygon)   
    end    
  end

end

