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

    monitor.setCursorPos(x + 1, math.ceil(height / 2))
    print("Exit")

    if (utils.hitTest(touchX, touchY, box)) then
        exit = true
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

    exitButton(1, 1, 6, 3, colors.red)

    utils.drawBox(width, height, math.floor(width / 2), math.floor(height / 2), colors.green)
    monitor.setCursorPos(math.floor(width / 2) + 6, math.floor(height / 2) + 4)
    print("Hi!")

    touchX = -1
    touchY = -1
end

while true do
    parallel.waitForAny(update, draw)

    if (exit) then
        break
    end
end

utils.clear(monitor)

clean()
