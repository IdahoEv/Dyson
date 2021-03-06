require "middleclass" -- definition of useful class construction methods
require 'constants'
require 'spob'
require 'segment'
require 'face'
require 'face_agro'
local matrix = require 'matrix_utils'

-- Construct class: Spob composed of multiple Segments

Construct = Spob:subclass('Construct')

-- For now, constructs are all cylinders; later refactor this
-- so we pass in a "geometry" object that specifies how the
-- segments are shaped and how they connect.
function Construct:initialize(
    host, 
    n_segments, 
    radius, 
    height,
    thickness, 
    period, 
    rotation_axis
  )
  Spob.initialize(self,host)

  self.n_segments = n_segments
  self.radius = radius
  self.height = height
  self.thickness = thickness
  self.rotational_period = period
  self.rotation_angle = 0 -- radians
  self.rotation_axis = matrix.unit(rotation_axis)

  local angle_subtended = TAU / n_segments -- in radians
  self.segments = { }

  -- compute a rotation matrix between the z-axis and the desired axis of the
  -- cylinder
  rot_matrix = matrix.rot_matrix_between(matrix:new{0,0,1}, self.rotation_axis)

  -- construct segments around the z-axis
  for s = 1, n_segments do
    -- faces should include 6 faces in the most general case
    -- but here we're simplifying to two faces.
    local outer_radius = self.radius + self.thickness
    local half_height = math.floor(height / 2)
    local start = { x = math.cos((s-1) * angle_subtended) * self.radius, 
		    y = math.sin((s-1) * angle_subtended) * self.radius } 
    local stop  = { x = math.cos(s * angle_subtended) * self.radius, 
		    y = math.sin(s * angle_subtended) * self.radius } 
    local start2 = { x = math.cos((s-1) * angle_subtended) * outer_radius , 
		    y = math.sin((s-1) * angle_subtended) * outer_radius } 
    local stop2  = { x = math.cos(s * angle_subtended) * outer_radius, 
		    y = math.sin(s * angle_subtended) * outer_radius } 

    -- Walk out the points of the face in counterclockwise fashion
    -- counterclockwise so that a cross product of (p2-p1 X p3-p1) 
    -- will give us a proper outward-facing normal.
    local p1 = matrix{ start.x, start.y,  half_height }
    local p2 = matrix{ start.x, start.y, -half_height }
    local p3 = matrix{ stop.x,  stop.y,  -half_height }
    local p4 = matrix{ stop.x,  stop.y,   half_height }

    local p5 = matrix{ start2.x, start2.y,  half_height }
    local p6 = matrix{ stop2.x,  stop2.y,   half_height }
    local p7 = matrix{ stop2.x,  stop2.y,  -half_height }
    local p8 = matrix{ start2.x, start2.y, -half_height }

    -- All rings are red-type on the inside, blue-type on the outside.
    -- Todo: generalize this to be information about type that is passed in
    -- to the Construct constructor.
    local faces = { FaceAgro:new({p1, p2, p3, p4}),
		    Face:new({p5, p6, p7, p8}, {R = 100, G = 100, B = 220}) }
    segment = Segment:new(self, faces)
    segment:rotateInitialFaces(rot_matrix)

    table.insert(self.segments, segment)

--    for seg_i, seg in pairs(self.segments) do
--      print(string.format('Segment %d is %s )\n',
--			  seg_i, unpack(seg)))
--    end
  end
  --  print string.format(unpack(segments))
  
end

-- Overload isVisible to check their radius rather than 
-- their orbital radius, which is what the Spob class does.
function Construct:isVisible(min_dist, max_dist)
  -- If this Construct *is* the view_center, it's obviously visible.
  if self == scale.view_center then return true end
  -- Otherwise, check the distance constraints
  local dist_from_center  = self:distanceFromPoint(scale:viewCenterLocation())
  local dist_from_host    = self.radius
  if (dist_from_center < max_dist) and
    ((self.host == nil) or (dist_from_host > min_dist)) then
      return true
  end
  return false
end

function Construct:updateCoords(time)
  Spob.updateCoords(self,time)

  
  self.rotation_angle = - time / self.rotational_period
  local rot_matrix = matrix.rotmatrix(self.rotation_axis, self.rotation_angle)
  for seg_i, segment in pairs(self.segments) do
    segment:updateFaces(rot_matrix)
  end
end
