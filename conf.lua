-- Tried the technique described here, but couldnet get it to work:
function love.conf(t)

  -- http://love2d.org/forums/viewtopic.php?f=4&t=2401&p=25864&hilit=resolution#p25864
  t.screen.width = 0
  t.screen.height = 0

  t.title = "Dyson"
  t.author = "Kiri and Evan"

  t.modules.joystick = false
  t.modules.physics = false
end