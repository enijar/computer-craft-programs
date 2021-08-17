function download(url, file)
  local content = http.get(url).readAll()
  if not content then
    error("Could not connect to website")
  end
  f = fs.open(file, "w")
  f.write(content)
  f.close()
end

function exitButton(x, y, width, height, color)
  local box = utils.drawBox(x, y, width, height, color)

  monitor.setCursorPos(x + 1, y + 1)
  print("Exit")

  if (utils.hitTest(touchX, touchY, box)) then
    exit = true
  end
end

function rebootButton(x, y, width, height, color)
  local box = utils.drawBox(x, y, width, height, color)

  monitor.setCursorPos(x + 1, y + 1)
  print("Reboot")

  if (utils.hitTest(touchX, touchY, box)) then
    reboot = true
  end
end

download("http://enijar.eu.ngrok.io/utils.lua", "utils")

utils = require("utils")

function clean()
  utils.delete("utils")
end

--connect to monitor
monitor = peripheral.find("monitor")
term.redirect(monitor)

--globals
exit = false
reboot = false
touchX = -1
touchY = -1
time = 0
lastDrawTime = 0
fps = 1 / 12

function update()
  event, side, x, y = os.pullEvent("monitor_touch")
  touchX = x
  touchY = y
end

function draw()
  if time - lastDrawTime < fps then
    time = time + 1
    sleep(fps)
  else
    lastDrawTime = time
  end

  local width, height = term.getSize()

  utils.clear(monitor)

  exitButton(1, height - 5, 7, 2, colors.red)
  rebootButton(1, height - 2, 7, 2, colors.orange)

  local cx = math.floor((width - 8) / 2)
  local cy = math.floor((height - 4) / 2)
  local x = (1 + math.sin(time / 5) / 2) * cx;
  local y = (1 + math.cos(time / 5) / 2) * cy;
  local ball = utils.drawImage("ball.nfp", x, y, 9, 5)

  if (utils.hitTest(touchX, touchY, ball)) then
    reboot = true
  end

  touchX = -1
  touchY = -1
end

while true do
  parallel.waitForAny(update, draw)

  if (exit or reboot) then
    break
  end
end

utils.clear(monitor)
clean()

if (reboot) then
  print("Rebooting...")
  shell.run("disk/run.lua")
end
