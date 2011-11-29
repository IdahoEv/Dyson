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
function Segment:updateFaces(theta)
  self.current_faces = {}
  for face_i, face in pairs(self.initial_faces) do
    local rotated_face = {}
    for point_i, point in pairs(face) do
      local sin_theta = math.sin(theta)
      local cos_theta = math.cos(theta)
      --local rot_p = { x = point.x * cos_theta - point.y * sin_theta,
      --		y = point.x * sin_theta + point.y * cos_theta }
      -- This is a 3D rotation matrix around the z axis
      local rot_p = matrix{{cos_theta,-sin_theta,0},
                           {sin_theta, cos_theta,0},
                           {        0,         0,1}} * point    
      --local p = { x = rot_p.x + construct_location.x,
      --	    y = rot_p.y + construct_location.y }
      rotated_face[point_i] = rot_p
    end
    self.current_faces[face_i] = rotated_face
  end    
end
