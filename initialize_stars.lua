require 'paintable_disc'

SOL_RADIUS  = 6.955e5 -- km

sol = Spob:new() -- Sol
sol.name = "Sol"
sol.paintable = PaintableDisc:new(sol,{ R = 225, G = 225, B = 0 })
sol:setRadius(SOL_RADIUS)
sol:setOrbitalRadius(0)
sol:setOrbitalPeriod(1)
sol:setCenter(CENTER)

return { sol = sol }
