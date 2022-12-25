--[[
	new whitelist cracked by m1kecorp

	was held hostage by lofi to do his job!!! 😡😡	

	did Hamstagang a favor ❣️ 
]]-- 

local m1kestagang
m1kestagang = hookfunction(game.HttpGet, function(LofiWas, here, ...)
    if here == "https://kylndantas-key-system.kylndantas.repl.co/verify" then
        return "f06baa562807eb1f7b735409a7ef2efb32b7a7d744c73bedd822f95fed19f480"
    elseif here == "https://raw.githubusercontent.com/KylnDantas/Valiant-UI/main/file.lua" then
        here = "https://raw.githubusercontent.com/Mstir16/legocheats/main/archive/Kengun%20Online/BabyHamstaFan/Valiant-UI.lua"
        return m1kestagang(LofiWas, here, ...)
    end
    return m1kestagang(LofiWas, here, ...)
end)

setreadonly(syn, false)

local lofiontop = syn.request
syn.request = function(loafhub)
    if loafhub.Url == "https://raw.githubusercontent.com/KylnDantas/InstanceProtect/main/source.lua" then
        loafhub.Url = "https://raw.githubusercontent.com/Mstir16/legocheats/main/archive/Kengun%20Online/BabyHamstaFan/InstanceProtect.lua"
	return lofiontop(t)
    end
    return lofiontop(t)
end

getgenv().bypassran = true

-- ^^ABOVE IS BYPASS
-- BELOW IS NORMAL SOURCE
getgenv().isPermanent = false;
getgenv().key = 'VzpFKKKTkPdwnnGD9hc17oF3NtlHLyfntkJbI0TWKh6Eqn1EdMjpJB2Az9FSPDmd'

loadstring(game:HttpGet("https://raw.githubusercontent.com/Mstir16/legocheats/main/archive/Kengun%20Online/BabyHamstaFan/script.lua"))()
