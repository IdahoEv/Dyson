require 'paintable_disc'
require 'paintable_star'

SOL_RADIUS  = 6.955e5 -- km

sol = Spob:new() -- Sol
sol.name = "Sol"
-- sol.paintable = PaintableDisc:new(sol,{ R = 225, G = 225, B = 0 })
sol.paintable = PaintableStar:new(sol, 'yellow', { R = 225, G = 225, B = 0 })
sol:setRadius(SOL_RADIUS)
sol:setOrbitalRadius(0)
sol:setOrbitalPeriod(1)

return { sol }
