require 'middleclass'
require 'spob'
require 'face'
local matrix = require 'matrix_utils'

FaceAgro = Face:subclass('FaceAgro')

function FaceAgro:initialize(coords)
  self.coords = coords
  -- Hack for now; assume face has at least 3 points
  self.color = { R = 0, G = 200, B = 0 }
  self.image = love.graphics.newImage("images/grass.png")
end

