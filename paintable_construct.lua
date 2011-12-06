require "middleclass" -- definition of useful class construction methods
require "paintable"
local matrix = require 'matrix_utils'

PaintableConstruct = Paintable:subclass('PaintableConstruct')

function PaintableConstruct:initialize(spob, color)
  self.spob  = spob
  self.color = color
end


function PaintableConstruct:draw()
  local segments = self.spob.segments

  
  local construct_location = self.spob:getLocation()
  local star_location = construct_location + self.spob:getStar():getLocation()

  for seg_i, segment in pairs(self.spob.segments) do
    for face_i, face in pairs(segment.current_faces) do


      polygon = {}
      normal = matrix.unit_cross(face[1],face[2],face[3])
     
      view_facingness = math.abs(matrix.dot(normal, VIEW_AXIS))
      sun_vector = self:faceCenter(face) + star_location
      sun_facingness = matrix.dot(normal, matrix.unit(sun_vector))
      if (sun_facingness > 0) then
        illumination= 0.4 + 0.6 * sun_facingness
      else
        illumination = 0.4
      end
      color_scale = (0.3 + 0.7 * view_facingness) * illumination

      for _, point in pairs(face) do
        local screen_x, screen_y = scale:screenCoords(point + construct_location)
        table.insert(polygon, screen_x)
        table.insert(polygon, screen_y)
      end
      -- Need line mode to be able to see edge-on polygons!
        
      love.graphics.setColor(
        self.color.R * color_scale, 
        self.color.G * color_scale, 
        self.color.B * color_scale
      )

      love.graphics.polygon("fill", polygon)      
      love.graphics.setColor(
        self.color.R * .8 * color_scale, 
        self.color.G * .8 * color_scale, 
        self.color.B * .8 * color_scale
      )
      love.graphics.polygon("line", polygon)   
    end    
  end

end

function PaintableConstruct:faceCenter(face)
  local sum = matrix:new{0,0,0}
  for _, point in pairs(face) do
    sum = sum + point
  end
  return sum / #face
end
