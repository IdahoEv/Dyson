-- More matrix stuff we needed that the library didn't provide.
require 'math'
local matrix = require 'lua-matrix/lua/matrix'

-- Like the main matrix library, we assume throughout that
-- these matrices are 3x1 or 3x3, as appropriate.

-- cross product matrix for 3x1 m (thank you, wikipedia)
function matrix.crossprodmatrix(m)
  local m_x = m[1][1]
  local m_y = m[2][1]
  local m_z = m[3][1]
  return matrix{{   0, -m_z,  m_y},
		{ m_z,    0, -m_x},
		{-m_y,  m_x,    0}}
end

-- tensor product of 3x1 m with itself
function matrix.tensorprod(m)
  local m_x = m[1][1]
  local m_y = m[2][1]
  local m_z = m[3][1]
  return matrix{{m_x * m_x, m_y * m_x, m_z * m_x},
		{m_x * m_y, m_y * m_y, m_z * m_y},
		{m_x * m_z, m_y * m_z, m_z * m_z}}
end

function matrix.rotmatrix(axis, theta)
  local cos_theta = math.cos(theta)
  local sin_theta = math.sin(theta)
  return matrix:new(3,'I') * cos_theta + 
    sin_theta * matrix.crossprodmatrix(axis) + 
    (1-cos_theta) * matrix.tensorprod(axis)
end

-- returns a rotation matrix that will rotate vector 1
-- onto vector 2.
function matrix.rot_matrix_between(vec1, vec2)
  cross = matrix.cross(vec1, vec2)
  axis = matrix.unit(cross)
  angle = math.asin(matrix.normf(cross))
  return matrix.rotmatrix(axis, angle)
end

-- returns a unit vector in the direction of v,
-- which must be a vector
function matrix.unit(v)
  return v / matrix.normf(v)
end

return matrix
