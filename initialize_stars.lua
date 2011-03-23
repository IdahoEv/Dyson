SOL_RADIUS  = 6.955e5 -- km

sol = Spob:new() -- Sol
sol.name = "Sol"
sol:setColor({ R = 200, G = 200, B = 0 })
sol:setRadius(SOL_RADIUS)
sol:setOrbitalRadius(0)
sol:setOrbitalPeriod(1)
sol:setCenter(CENTER)

return { sol = sol }
