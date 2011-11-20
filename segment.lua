require 'constants'
require 'middleclass'
require "spob"

Segment = class('Segment')

function Segment:initialize(construct, faces)
  self.construct = construct
  self.faces = faces
end

-- Return the (absolute) x,y coordinates of this Segment
function Segment:getLocation()
   local construct_x, construct_y, construct_z

   construct_loc = self.construct:getLocation()
 
   -- print(self.name, construct_loc.x, construct_loc.y)
   return { x = self.location.x + construct_loc.x,
            y = self.location.y + construct_loc.y,
            z = self.location.z + construct_loc.z }
end

