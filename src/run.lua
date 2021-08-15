function download(url, file)
    local content = http.get(url).readAll()
    if not content then
        error("Could not connect to website")
    end
    f = fs.open(file, "w")
    f.write(content)
    f.close()
end

function delete(file)
    if (fs.exists(file)) then
        fs.delete(file)
    end
end

delete("ui.lua")
download("http://enijar.eu.ngrok.io/ui.lua", "ui.lua")
shell.run("ui")
delete("ui.lua")
