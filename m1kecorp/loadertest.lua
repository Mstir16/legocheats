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
