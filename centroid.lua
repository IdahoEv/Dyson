require "middleclass" -- definition of useful class construction methods
require 'constants'
require "spob"

Centroid = Spob:subclass('Centroid')

function Centroid:initialize(host, mass)
  Spob.initialize(self, host)

  -- a bare paintable just shows the name
  self.paintable = Paintable:new(self)
end

function Centroid:draw(scale)
  print('Drawing centroid', self.name)
  Spob.draw(self, scale)
end