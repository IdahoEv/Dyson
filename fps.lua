function initializeFPS()
  time_history = { 1, 1, 1, 1, 1 }
  fps = 0
end

function updateFPS(dt)
  table.remove(time_history, 1)
  table.insert(time_history, dt)
  sum = 0
  for _, delta in ipairs(time_history) do
    sum = sum + delta
  end
  fps = (# time_history) / sum
end