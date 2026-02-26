--// RIIICUY HUB BOOTSTRAPPER
--// Link: https://github.com/rizalputraaa/riiicuy-hub
local user = "rizalputraaa" 

local function load(file)
    local success, result = pcall(function()
        return game:HttpGet("https://raw.githubusercontent.com/"..user.."/riiicuy-hub/main/"..file)
    end)
    if success then
        return loadstring(result)()
    else
        warn("Gagal memuat file: "..file)
    end
end

-- Logo ASCII di F9 (Console)
print([[
  _____  _____ _____ _____ _____ _    ___     __
 |  __ \|_   _|_   _/ ____|  __ \ |  | \ \   / /
 | |__) | | |   | || |    | |  | | |  | |\ \_/ / 
 |  _  /  | |   | || |    | |  | | |  | | \   /  
 | | \ \ _| |_ _| || |____| |__| | |__| |  | |   
 |_|  \_\_____|_____\_____|_____/\____/   |_|   
          BY RIZALPUTRAAA
]])

pcall(function() load("notif.lua") end)
task.wait(1.5)
pcall(function() load("engine.lua") end)
