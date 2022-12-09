if _G.REGAUTH == nil then return end

local domain = "https://mistr-is-fine-asf.deta.dev"

local data = {
    ["regAuth"] = _G.REGAUTH,
    ["rbxUID"] = game.Players.LocalPlayer.UserId,
}

local reqfunc = (fluxus or http or syn).request;
local content = reqfunc(
    {
        Url = domain.."/register",
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game:GetService("HttpService"):JSONEncode(data)
    }
)

content = content.Body

game:GetService("StarterGui"):SetCore("SendNotification",{
	Title = "Mstir's Archives", -- Required
	Text = content, -- Required
})
