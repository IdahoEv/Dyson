preferences = {
  enlarge_planets    = false,
  show_orbits        = true,
  show_reticle       = true
}

function preferences.toggle(key)
  if preferences[key] ~= nil then
    preferences[key] = not preferences[key]
  end
end

