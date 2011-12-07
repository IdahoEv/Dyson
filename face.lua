require 'middleclass'
require 'spob'

Face = class('Face')

-- For now, pass in desired properties of each face.
-- Ultimately we will probably subclass this to 
-- represent different aspects/behavior for different types
-- (habitation, solar collection, mining, factory, computing...)
function Face:initialize(coords, color)
  self.coords = coords
  self.color = color
end

