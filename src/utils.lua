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
    paintutils.drawFilledBox(x, y, width, height, color)
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

return { clear = clear, hitTest = hitTest, drawBox = drawBox, delete = delete }
