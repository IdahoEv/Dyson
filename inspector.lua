require "middleclass" -- definition of useful class construction methods
require 'constants'
require 'text'

Inspector = class('Inspector')

-- Create a inspector for the indicated Spob
function Inspector:initialize(spob)
  self.spob = spob
  self.title = "Inspector"
  self.width = 180
end

function Inspector:draw(scale)
  local attr = self.spob:getAttribs()
  local num_attr = 0
  -- OMG I have to do this myself?!
  for _, _ in pairs(attr) do
    num_attr = num_attr + 1
  end
  -- Check whether the spob is (still) in view
  local x, y = scale:screenCoords(self.spob:getLocation())
  -- Create a see-through box to the right of the spob
  local box_width  = self.width
  local box_height = num_attr * 20
  local box_upperLx = x+10
  local box_upperLy = y
  love.graphics.setColor(50, 50, 100, 200)
  love.graphics.rectangle('fill', box_upperLx, box_upperLy,
                          box_width, box_height)
  love.graphics.setColor(50, 50, 200, 255)
  love.graphics.rectangle('line', box_upperLx, box_upperLy,
                          box_width, box_height)
  love.graphics.setColor(255, 255, 255)
  -- Show the spob's attributes
  textLine{str = self.spob.name, x = box_upperLx+3, y = box_upperLy+2}
  for key, att in pairs(attr) do
    textLine{str = key .. ': ' .. att}
  end
  -- Permit editing
end
