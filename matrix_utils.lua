-- More matrix stuff we needed that the library didn't provide.
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
