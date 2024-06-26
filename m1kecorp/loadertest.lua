if game.PlaceId == 4282985734 or game.PlaceId == 11979315221 and hookfunction then
    if getgenv().CWAC == nil then
        getgenv().CWAC = true
        local oRequire
        oRequire = hookfunction(getrenv().require, function(moduleScript)
            local moduleData = oRequire(moduleScript)
        
            if moduleScript.Name == "AntiCheatHandlerClient" then
                local startFunction = moduleData._startModule
        
                function moduleData:_startModule()
                    local network = debug.getupvalue(startFunction, 2)
                    network:FireServer("BAC", debug.getupvalue(startFunction, 1)())
                    network:BindEvents({
                        CreateAntiCheatNotification = moduleData.createNotification
                    })
                end
        
                hookfunction(getrenv().require, oRequire) --restorefunction()
            end
        
            return moduleData
        end) 
    end
end

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer.Character ~= nil

local http
pcall(function()
http = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
end)

if http == nil then return print("unsupported exploit - LOADER") end

local function GetGames()
   local response = http({
        Url = "https://api.github.com/repos/Mstir16/legocheats/contents/m1kecorp/games",
        Method = "GET",
    })

    
    local data = game.HttpService:JSONDecode(game.HttpService:JSONDecode(game.HttpService:JSONEncode(response.Body)))
    return data
end

local GamesList = GetGames()
local PID = game.PlaceId

for i,v in pairs(GamesList) do
    local script = v["download_url"]
    local script_name = v["name"]
    
    if script_name:find(tostring(PID)) then
        print("loaded "..script_name.." - LOADER")
        loadstring(game:HttpGet(script))()
        break
    end
end
