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

      
      local polygon = {}
      local normal = matrix.unit_cross(face.coords[1],face.coords[2],face.coords[3])
     
      local view_facingness = matrix.dot(normal, VIEW_AXIS)

      -- only draw faces that are facing us
      if ( view_facingness > 0 ) then

        local sun_vector = self:faceCenter(face) + star_location
        local sun_facingness = matrix.dot(normal, matrix.unit(sun_vector))
        local illumination = 0.0
        if (sun_facingness > 0) then
          illumination= 0.4 + 0.9 * sun_facingness
        else
          illumination = 0.4
        end
        local color_scale = (0.4 + 0.6 * view_facingness) * illumination

        for _, point in pairs(face.coords) do
          local screen_x, screen_y = scale:screenCoords(point + construct_location)
          table.insert(polygon, screen_x)
          table.insert(polygon, screen_y)
        end
        love.graphics.setColor(
          face.color.R * color_scale, 
          face.color.G * color_scale, 
          face.color.B * color_scale
        )
        love.graphics.polygon("fill", polygon)      
        local wireframe_scale = math.max(0.8 * color_scale, 0.3)
        love.graphics.setColor(
	  self.color.R * wireframe_scale, 
          self.color.G * wireframe_scale, 
          self.color.B * wireframe_scale
        )
        love.graphics.polygon("line", polygon)   
      end
    end    
  end

end

function PaintableConstruct:faceCenter(face)
  local sum = matrix:new{0,0,0}
  for _, point in pairs(face.coords) do
    sum = sum + point
  end
  return sum / #face.coords
end
