function clear(monitor)
  monitor.setBackgroundColour(colors.black)
  monitor.clear()
  monitor.setCursorPos(1, 1)
end

function hitTest(touchX, touchY, box)
  if box == nil then
    return
  end
  if (touchX >= box.x and touchX <= box.x + box.width and touchY >= box.y and touchY <= box.y + box.height) then
    return true
  end
  return false
end

function drawBox(x, y, width, height, color)
  paintutils.drawFilledBox(x, y, x + width, y + height, color)
  local box = {}
  box.x = x
  box.y = y
  box.width = width
  box.height = height
  return box
end

function join(s, tab)
  return (s:gsub('($%b{})', function(w)
    return tab[w:sub(3, -2)] or w
  end))
end

function download(url, file)
  local content = http.get(url).readAll()
  if not content then
    error("Could not connect to website")
  end
  f = fs.open(file, "w")
  f.write(content)
  f.close()
end

local cachedImages = {}
function drawImage(src, x, y, width, height)
  if cachedImages[src] == nil then
    local url = join("http://enijar.eu.ngrok.io/${src}", { src = src })
    download(url, src)
    cachedImages[src] = paintutils.loadImage(src)
    delete(src)
  end
  paintutils.drawImage(cachedImages[src], x, y)
  local box = {}
  box.x = x
  box.y = y
  box.width = width
  box.height = height
  return box
end

function delete(file)
  if (fs.exists(file)) then
    fs.delete(file)
  end
end

return {
  clear = clear,
  hitTest = hitTest,
  drawBox = drawBox,
  delete = delete,
  drawImage = drawImage,
  join = join,
  download = download
}
