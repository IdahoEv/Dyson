require 'constants'
require 'middleclass'
require "spob"

local matrix = require "lua-matrix/lua/matrix"

Segment = class('Segment')

function Segment:initialize(construct, faces)
  self.construct = construct
  self.initial_faces = faces
  self.current_faces = {}
  self:updateFaces(0)
end

-- Return the (absolute) x,y coordinates of this Segment
function Segment:getLocation()
   construct_loc = self.construct:getLocation()
 
   return self.location + contruct_loc  
end

-- figure current location of faces, rotated by theta from original location
function Segment:updateFaces(rot_matrix)
  self.current_faces = {}
  for face_i, face in pairs(self.initial_faces) do
    local rotated_face = {}
    for point_i, point in pairs(face) do
      --local p = { x = rot_p.x + construct_location.x,
      --	    y = rot_p.y + construct_location.y }
      rotated_face[point_i] = rot_matrix * point
    end
    self.current_faces[face_i] = rotated_face
  end    
end
