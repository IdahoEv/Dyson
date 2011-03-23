require 'constants'

function initializeScreen()
  desktop_size = { width = love.graphics.getWidth(), height = love.graphics.getHeight() }
  -- print(desktop_size.width, desktop_size.height)
  fullscreen = false
  love.graphics.setMode(DEFAULT_WINDOW_SIZE.width, DEFAULT_WINDOW_SIZE.height, fullscreen, true, 0)
end

function toggleFullscreen()
  fullscreen = not fullscreen
  if fullscreen then
    love.graphics.setMode(desktop_size.width, desktop_size.height, fullscreen, true, 0)
  else
    love.graphics.setMode(DEFAULT_WINDOW_SIZE.width, DEFAULT_WINDOW_SIZE.height, fullscreen, true, 0)
  end
  scale:detectScreenSize()
end