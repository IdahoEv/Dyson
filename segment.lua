require 'constants'
require 'middleclass'
require "spob"

local matrix = require 'matrix_utils'

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
function Segment:rotateFaces(rot_matrix)
  local result_faces = {}
  for face_i, face in pairs(self.initial_faces) do
    local rotated_face = {}
    for point_i, point in pairs(face) do
      rotated_face[point_i] = rot_matrix * point
    end
    result_faces[face_i] = rotated_face
  end    
  return result_faces
end

function Segment:rotateInitialFaces(rot_matrix) 
  self.initial_faces = self:rotateFaces(rot_matrix)
end

function Segment:updateFaces(rot_matrix)
  self.current_faces = self:rotateFaces(rot_matrix)
end


