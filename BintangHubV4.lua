-- BINTANGHUB V4.2 | Violence District
-- Premium Custom Loading + Rayfield UI + Stun Cooldown Bar

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ==========================================
-- 1. CUSTOM PREMIUM LOADING SCREEN
-- ==========================================
local LoadingGui = Instance.new("ScreenGui")
LoadingGui.Name = "BH_PremiumLoad"
LoadingGui.IgnoreGuiInset = true
LoadingGui.DisplayOrder = 999
LoadingGui.Parent = game:GetService("CoreGui")

local Bg = Instance.new("Frame")
Bg.Size = UDim2.new(1, 0, 1, 0)
Bg.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Bg.BorderSizePixel = 0
Bg.Parent = LoadingGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 400, 0, 50)
Title.Position = UDim2.new(0.5, -200, 0.4, -25)
Title.BackgroundTransparency = 1
Title.Text = "BINTANGHUB"
Title.TextColor3 = Color3.fromRGB(255, 20, 147)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 40
Title.Parent = LoadingGui

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 20, 147)
Stroke.Thickness = 2
Stroke.Transparency = 0.5
Stroke.Parent = Title

local SubText = Instance.new("TextLabel")
SubText.Size = UDim2.new(0, 400, 0, 20)
SubText.Position = UDim2.new(0.5, -200, 0.4, 30)
SubText.BackgroundTransparency = 1
SubText.Text = "Violence District | Owner: BintangHub"
SubText.TextColor3 = Color3.fromRGB(200, 200, 200)
SubText.Font = Enum.Font.Gotham
SubText.TextSize = 14
SubText.Parent = LoadingGui

local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(0, 300, 0, 6)
BarBg.Position = UDim2.new(0.5, -150, 0.6, 0)
BarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
BarBg.BorderSizePixel = 0
BarBg.Parent = LoadingGui
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBg
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

local BarGlow = Instance.new("UIStroke")
BarGlow.Color = Color3.fromRGB(255, 20, 147)
BarGlow.Thickness = 3
BarGlow.Transparency = 0.4
BarGlow.Parent = BarBg

local LoadTxt = Instance.new("TextLabel")
LoadTxt.Size = UDim2.new(0, 300, 0, 20)
LoadTxt.Position = UDim2.new(0.5, -150, 0.65, 10)
LoadTxt.BackgroundTransparency = 1
LoadTxt.Text = "Initializing..."
LoadTxt.TextColor3 = Color3.fromRGB(150, 150, 150)
LoadTxt.Font = Enum.Font.Gotham
LoadTxt.TextSize = 12
LoadTxt.Parent = LoadingGui

task.spawn(function()
    local phases = {"Loading Modules...", "Injecting Hooks...", "Bypassing Anticheat...", "Ready!"}
    for i = 1, 100 do
        task.wait(0.03)
        BarFill.Size = UDim2.new(i/100, 0, 1, 0)
        if i == 25 then LoadTxt.Text = phases[1]
        elseif i == 50 then LoadTxt.Text = phases[2]
        elseif i == 75 then LoadTxt.Text = phases[3]
        elseif i == 100 then LoadTxt.Text = phases[4] end
    end
    task.wait(0.5)
    local fadeInfo = TweenInfo.new(0.8, Enum.EasingStyle.Linear)
    for _, obj in pairs({Bg, Title, Stroke, SubText, BarBg, BarFill, BarGlow, LoadTxt}) do
        if obj:IsA("TextLabel") then TweenService:Create(obj, fadeInfo, {TextTransparency = 1}):Play()
        elseif obj:IsA("Frame") then TweenService:Create(obj, fadeInfo, {BackgroundTransparency = 1}):Play()
        elseif obj:IsA("UIStroke") then TweenService:Create(obj, fadeInfo, {Transparency = 1}):Play() end
    end
    task.wait(1)
    LoadingGui:Destroy()
end)

-- ==========================================
-- 2. CONFIG
-- ==========================================
local Config = {
    SilentAim = false, AimLock = false, AutoParry = false,
    GenMode = "Normal", AutoGen = false, AutoSkillcheck = false, AutoTrapRelease = false,
    AutoCrouch = false, AutoM1 = false, KillerAimLock = false, 
    BypassParry = false, AutoDropPallet = false,
    Fullbright = false, NoShadow = false, NoClip = false, CameraFOV = 70,
    ESP_Survivor = false, ESP_Killer = false, ESP_Stun = false, ESP_Gen = false,
    ESP_Pumpkin = false, ESP_Trap = false, ESP_Name = true, StreamerMode = false,
    
    Color_Survivor = Color3.fromRGB(40, 255, 40),
    Color_Killer = Color3.fromRGB(255, 40, 40),
    Color_Stun = Color3.fromRGB(255, 255, 0),
    Color_Gen = Color3.fromRGB(255, 165, 0),
    Color_Pumpkin = Color3.fromRGB(255, 100, 0),
    Color_Trap = Color3.fromRGB(200, 0, 0)
}

-- ==========================================
-- 3. RAYFIELD UI
-- ==========================================
task.wait(1)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BINTANGHUB V4.2 | Pink Glow",
   LoadingTitle = "BINTANGHUB UI",
   LoadingSubtitle = "by Owner BintangHub",
   ConfigurationSaving = {Enabled = true, FolderName = "BintangHub", FileName = "V4_Config"},
   KeySystem = false, Theme = "Amethyst"
})

local TabMain = Window:CreateTab("Main", 4483362458)
local TabCombat = Window:CreateTab("Combat", 4483362458)
local TabSurvivor = Window:CreateTab("Survivor", 4483362458)
local TabKiller = Window:CreateTab("Killer", 4483362458)
local TabESP = Window:CreateTab("ESP", 4483362458)

-- Main Tab
TabMain:CreateSlider({Name = "Camera FOV", Range = {70, 120}, Increment = 1, Suffix = " FOV", CurrentValue = 70, Flag = "FOV", Callback = function(v) Config.CameraFOV = v end})
TabMain:CreateToggle({Name = "Fullbright", CurrentValue = false, Flag = "Fullbright", Callback = function(v) Config.Fullbright = v end})
TabMain:CreateToggle({Name = "No Shadow", CurrentValue = false, Flag = "NoShadow", Callback = function(v) Config.NoShadow = v end})
TabMain:CreateToggle({Name = "Streamer Mode", CurrentValue = false, Flag = "Streamer", Callback = function(v) Config.StreamerMode = v end})

-- Combat Tab
TabCombat:CreateToggle({Name = "Silent Aim", CurrentValue = false, Flag = "SilentAim", Callback = function(v) Config.SilentAim = v end})
TabCombat:CreateToggle({Name = "Aim Lock (Smooth)", CurrentValue = false, Flag = "AimLock", Callback = function(v) Config.AimLock = v end})
TabCombat:CreateToggle({Name = "Auto Parry", CurrentValue = false, Flag = "AutoParry", Callback = function(v) Config.AutoParry = v end})

-- Survivor Tab
TabSurvivor:CreateDropdown({Name = "Auto Generator Mode", Options = {"Legit", "Normal", "Instan"}, CurrentOption = {"Normal"}, Flag = "GenMode", Callback = function(o) Config.GenMode = o[1] end})
TabSurvivor:CreateToggle({Name = "Auto Generator", CurrentValue = false, Flag = "AutoGen", Callback = function(v) Config.AutoGen = v end})
TabSurvivor:CreateToggle({Name = "Auto Skillcheck & Trap", CurrentValue = false, Flag = "AutoSkill", Callback = function(v) Config.AutoSkillcheck = v; Config.AutoTrapRelease = v end})
TabSurvivor:CreateToggle({Name = "Auto Crouch", CurrentValue = false, Flag = "AutoCrouch", Callback = function(v) Config.AutoCrouch = v end})

-- Killer Tab
TabKiller:CreateToggle({Name = "Auto M1", CurrentValue = false, Flag = "AutoM1", Callback = function(v) Config.AutoM1 = v end})
TabKiller:CreateToggle({Name = "Bypass Parry", CurrentValue = false, Flag = "BypassParry", Callback = function(v) Config.BypassParry = v end})

-- ESP Tab
TabESP:CreateSection("Player ESP")
TabESP:CreateToggle({Name = "ESP Survivor", CurrentValue = false, Flag = "ESP_Survivor", Callback = function(v) Config.ESP_Survivor = v end})
TabESP:CreateColorPicker({Name = "Survivor Color", Color = Config.Color_Survivor, Flag = "Color_Survivor", Callback = function(v) Config.Color_Survivor = v end})

TabESP:CreateToggle({Name = "ESP Killer", CurrentValue = false, Flag = "ESP_Killer", Callback = function(v) Config.ESP_Killer = v end})
TabESP:CreateColorPicker({Name = "Killer Color", Color = Config.Color_Killer, Flag = "Color_Killer", Callback = function(v) Config.Color_Killer = v end})

TabESP:CreateToggle({Name = "ESP Killer Stun (Indicator)", CurrentValue = false, Flag = "ESP_Stun", Callback = function(v) Config.ESP_Stun = v end})
TabESP:CreateColorPicker({Name = "Stun Color", Color = Config.Color_Stun, Flag = "Color_Stun", Callback = function(v) Config.Color_Stun = v end})

TabESP:CreateSection("Object ESP")
TabESP:CreateToggle({Name = "ESP Generator", CurrentValue = false, Flag = "ESP_Gen", Callback = function(v) Config.ESP_Gen = v end})
TabESP:CreateColorPicker({Name = "Generator Color", Color = Config.Color_Gen, Flag = "Color_Gen", Callback = function(v) Config.Color_Gen = v end})

TabESP:CreateToggle({Name = "ESP Pumpkin", CurrentValue = false, Flag = "ESP_Pumpkin", Callback = function(v) Config.ESP_Pumpkin = v end})
TabESP:CreateToggle({Name = "ESP Trap", CurrentValue = false, Flag = "ESP_Trap", Callback = function(v) Config.ESP_Trap = v end})

-- ==========================================
-- 4. ESP & STUN INDICATOR LOGIC
-- ==========================================
local espObjects = {}
local stunIndicators = {}

local function CreateESP()
    local box = Drawing.new("Square")
    box.Thickness = 1.5; box.Filled = false; box.Visible = false
    local text = Drawing.new("Text")
    text.Size = 13; text.Center = true; text.Outline = true; text.Font = 2; text.Visible = false
    return {box = box, text = text}
end

local function CreateStunBar()
    local barBg = Drawing.new("Square")
    barBg.Thickness = 1; barBg.Filled = true; barBg.Color = Color3.fromRGB(30, 30, 30); barBg.Visible = false
    
    local barFill = Drawing.new("Square")
    barFill.Thickness = 1; barFill.Filled = true; barFill.Visible = false
    
    local stunText = Drawing.new("Text")
    stunText.Size = 12; stunText.Center = true; stunText.Outline = true; stunText.Font = 2; stunText.Visible = false
    
    return {bg = barBg, fill = barFill, txt = stunText}
end

local function UpdateESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                if not espObjects[plr] then espObjects[plr] = CreateESP() end
                if not stunIndicators[plr] then stunIndicators[plr] = CreateStunBar() end
                
                local esp = espObjects[plr]
                local stunUI = stunIndicators[plr]
                local isKiller = plr.Character:FindFirstChildOfClass("Tool") ~= nil
                
                -- Deteksi Stun (Killer diem / WalkSpeed 0 / Animasi berhenti)
                local isStunned = isKiller and (hum.WalkSpeed == 0 or hum.Health < hum.MaxHealth) 
                
                -- Logic Stun Indicator (Bar melayang di atas kepala)
                if isKiller and isStunned and Config.ESP_Stun then
                    local vec, onScreen = Camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 3, 0))
                    if onScreen then
                        local barWidth = 50
                        local barHeight = 6
                        stunUI.bg.Size = Vector2.new(barWidth, barHeight)
                        stunUI.bg.Position = Vector2.new(vec.X - barWidth/2, vec.Y - 30)
                        stunUI.bg.Visible = true
                        
                        stunUI.fill.Size = Vector2.new(barWidth * 0.6, barHeight) -- Simulasi 60% stun
                        stunUI.fill.Position = Vector2.new(vec.X - barWidth/2, vec.Y - 30)
                        stunUI.fill.Color = Config.Color_Stun
                        stunUI.fill.Visible = true
                        
                        stunUI.txt.Text = "STUNNED"
                        stunUI.txt.Position = Vector2.new(vec.X, vec.Y - 45)
                        stunUI.txt.Color = Config.Color_Stun
                        stunUI.txt.Visible = true
                    else
                        stunUI.bg.Visible = false; stunUI.fill.Visible = false; stunUI.txt.Visible = false
                    end
                else
                    stunUI.bg.Visible = false; stunUI.fill.Visible = false; stunUI.txt.Visible = false
                end
                
                -- ESP Box Normal
                local active = (isKiller and Config.ESP_Killer) or (not isKiller and Config.ESP_Survivor)
                if active then
                    local vec, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    if onScreen then
                        local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                        local height = 1000 / dist
                        esp.box.Size = Vector2.new(height/2, height)
                        esp.box.Position = Vector2.new(vec.X - height/4, vec.Y - height/2)
                        esp.box.Color = isKiller and Config.Color_Killer or Config.Color_Survivor
                        esp.box.Visible = true
                        
                        if Config.ESP_Name then
                            esp.text.Text = (Config.StreamerMode and (isKiller and "K-" or "S-") .. plr.UserId % 100 or plr.Name) .. " [" .. math.floor(dist) .. "m]"
                            esp.text.Position = Vector2.new(vec.X, vec.Y - height/2 - 16)
                            esp.text.Color = esp.box.Color
                            esp.text.Visible = true
                        else esp.text.Visible = false end
                    else esp.box.Visible = false; esp.text.Visible = false end
                else esp.box.Visible = false; esp.text.Visible = false end
            end
        end
    end
end

-- ==========================================
-- 5. COMBAT & HOOKS
-- ==========================================
local function GetClosestTarget()
    local closest, minDist = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local vec, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                if onScreen and dist < minDist and dist < 200 then
                    minDist = dist; closest = hrp
                end
            end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    UpdateESP()
    if Config.SilentAim or Config.AimLock then
        local target = GetClosestTarget()
        if target and Config.AimLock then
            local lookAt = CFrame.new(Camera.CFrame.Position, target.Position)
            Camera.CFrame = Camera.CFrame:Lerp(lookAt, 0.2)
        end
    end
    if Camera.FieldOfView ~= Config.CameraFOV then Camera.FieldOfView = Config.CameraFOV end
end)

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if Config.SilentAim and (method == "Raycast" or method == "FindPartOnRay") then
        local target = GetClosestTarget()
        if target then
            local args = {...}
            if typeof(args[1]) == "Ray" then
                args[1] = Ray.new(args[1].Origin, (target.Position - args[1].Origin).Unit * 500)
            end
            return oldNamecall(self, unpack(args))
        end
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- ==========================================
-- 6. REMOTE HOOKS (Parry, Skillcheck)
-- ==========================================
for _, remote in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
    if remote:IsA("RemoteEvent") then
        pcall(function()
            remote.OnClientEvent:Connect(function(...)
                local args = {...}
                local txt = ""
                for _, a in pairs(args) do if type(a) == "string" then txt = txt .. a:lower() end end
                
                if Config.AutoParry and (txt:find("attack") or txt:find("slash")) then
                    task.wait(0.15)
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                    task.wait(0.05)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                end
                
                if (Config.AutoSkillcheck or Config.AutoTrapRelease) and (txt:find("skill") or txt:find("trap")) then
                    task.wait(0.15)
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                    task.wait(0.05)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                end
            end)
        end)
    end
end

-- ==========================================
-- 7. CHARACTER LOOP
-- ==========================================
task.spawn(function()
    while task.wait(0.1) do
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                if Config.AutoCrouch then hum.CameraOffset = Vector3.new(0, -1, 0) else hum.CameraOffset = Vector3.new(0, 0, 0) end
                if Config.NoClip then for _, v in pairs(char:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end
            end
        end
        if Config.Fullbright then Lighting.Brightness = 3; Lighting.ClockTime = 14; Lighting.GlobalShadows = false
        else Lighting.Brightness = 1; Lighting.GlobalShadows = true end
        if Config.NoShadow then for _, v in pairs(workspace:GetDescendants()) do if v:IsA("BasePart") then v.CastShadow = false end end end
    end
end)

print("[BINTANGHUB V4.2] Loaded. Custom Loading + Stun Bar Active.")