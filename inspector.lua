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
  local x, y = scale:screenCoords(self.spob.location)
  if x <= 0 or y <= 0 or
    x > scale.screen_width and y > scale.screen_height then
    return
  end
  -- Create a see-through box to the right of the spob
  love.graphics.setColor(50, 50, 200, 150)
  love.graphics.rectangle('fill', x+10, y-10, self.width, num_attr * 20)
  love.graphics.setColor(255, 255, 255)
  -- Show the spob's attributes
  textLine{str = self.spob.name, x = x+12, y = y-8}
  for key, att in pairs(attr) do
    textLine{str = key .. ': ' .. att}
  end
  -- Permit editing
end
