combos = {}
visible = {}
num_keys = 0
mouse_moves = 0

eventtap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
  local modifiers = ""
  -- cmd+ctrl+alt+shift+fn
  if event:getFlags()['fn'] then
    modifiers = "fn+"
  end
  if event:getFlags()['shift'] then
    modifiers = "shift+" .. modifiers
  end
  if event:getFlags()['alt'] then
    modifiers = "alt+" .. modifiers
  end
  if event:getFlags()['ctrl'] then
    modifiers = "ctrl+" .. modifiers
  end
  if event:getFlags()['cmd'] then
    modifiers = "cmd+" .. modifiers
  end

  if string.len(modifiers) > 0 then
    modifiers = modifiers .. hs.keycodes.map[event:getKeyCode()]
    combos[modifiers] = combos[modifiers] or 0
    combos[modifiers] = combos[modifiers] + 1
  end

  local chars = event:getCharacters()
  visible[chars] = visible[chars] or 0
  visible[chars] = visible[chars] + 1

  num_keys = num_keys + 1
end)

mousetap = hs.eventtap.new({hs.eventtap.event.types.mouseMoved}, function(event)
  mouse_moves = mouse_moves + 1
end)

dumper = hs.timer.doEvery(300, function()
  local now = hs.timer.secondsSinceEpoch()

  local contents = { now=now, mouse_moves=mouse_moves }

  -- only output the keys results if there are enough
  if num_keys > 100 then
    contents.combos = combos
    contents.visible = visible
    contents.num_keys = num_keys
  else
    print(string.format("Not outputting keys because there are only %s", num_keys))
  end

  -- TODO: figure out how to parameterize this
  local filename = string.format("/Users/Tom/Dropbox (Personal)/Apps/keystats/%s.json", now)
  local file = assert(io.open(filename, 'w'))
  contents = hs.json.encode(contents)
  file:write(contents)
  file:close()

  if num_keys > 100 then
    combos = {}
    visible = {}
    num_keys = 0
  end

  mouse_moves = 0
end)

eventtap:start()
mousetap:start()
