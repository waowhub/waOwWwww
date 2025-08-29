-- Rayfield kütüphanesini yükle
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Pencere oluştur
local Window = Rayfield:CreateWindow({
    Name = "TPS: Ultimate Soccer Batu.wav",
    Theme = "DarkBlue",
    ToggleUIKeybind = "K",
    ConfigurationSaving = {
        Enabled = true,
        FileName = "TPSUltimateConfig"
    }
})

-- =======================
-- React Sekmesi
-- =======================
local ReactTab = Window:CreateTab("React", "rewind")
local MainSection = ReactTab:CreateSection("Main")
ReactTab:CreateButton({Name = "Main React", Callback = function() print("Main React clicked") end})
ReactTab:CreateButton({Name = "React Kill", Callback = function() print("React Kill clicked") end})
local OthersSection = ReactTab:CreateSection("Others")
ReactTab:CreateButton({Name = "EmreMorTPS React (Left)", Callback = function() print("Left clicked") end})
ReactTab:CreateButton({Name = "EmreMorTPS React (Right)", Callback = function() print("Right clicked") end})
ReactTab:CreateButton({Name = "Other 1", Callback = function() print("Other1 clicked") end})
ReactTab:CreateButton({Name = "Other 2", Callback = function() print("Other2 clicked") end})
ReactTab:CreateButton({Name = "Other 3", Callback = function() print("Other3 clicked") end})

-- =======================
-- Reach Sekmesi
-- =======================
local ReachTab = Window:CreateTab("Reach", "expand")
local FootArmsSection = ReachTab:CreateSection("Foot and Arms")
ReachTab:CreateSlider({Name = "Left Foot", Range = {1, 10}, Increment = 1, Suffix = "", CurrentValue = 1, Flag = "LeftFoot", Callback = function(val) print("Left Foot:", val) end})
ReachTab:CreateSlider({Name = "Right Foot", Range = {1, 10}, Increment = 1, Suffix = "", CurrentValue = 1, Flag = "RightFoot", Callback = function(val) print("Right Foot:", val) end})
ReachTab:CreateSlider({Name = "Left Arm", Range = {1, 10}, Increment = 1, Suffix = "", CurrentValue = 1, Flag = "LeftArm", Callback = function(val) print("Left Arm:", val) end})
ReachTab:CreateSlider({Name = "Right Arm", Range = {1, 10}, Increment = 1, Suffix = "", CurrentValue = 1, Flag = "RightArm", Callback = function(val) print("Right Arm:", val) end})

-- =======================
-- Body Sekmesi
-- =======================
local BodyTab = Window:CreateTab("Body", "user")
local BodySection = BodyTab:CreateSection("Body Options")
BodyTab:CreateButton({Name = "Blocky Body", Callback = function() print("Blocky Body clicked") end})
BodyTab:CreateButton({Name = "Original Body", Callback = function() print("Original Body clicked") end})

-- =======================
-- Boost Sekmesi
-- =======================
local BoostTab = Window:CreateTab("Boost", "zap")

-- Stamina Bölümü
local StaminaSection = BoostTab:CreateSection("Stamina")
BoostTab:CreateButton({
    Name = "Unlimited Stamina",
    Callback = function()
        -- Unlimited Stamina + Humanoid WalkSpeed 14 görünümü
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")

        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldIndex = mt.__index
        mt.__index = newcclosure(function(obj, prop)
            if tostring(obj) == "Humanoid" and tostring(prop) == "WalkSpeed" then
                return 14
            end
            return oldIndex(obj, prop)
        end)
        setreadonly(mt, true)

        humanoid.WalkSpeed = 22

        local RS = game:GetService("ReplicatedStorage")
        local WS = game:GetService("Workspace")
        local staminaRemotes = {}

        if WS:FindFirstChild("FE") and WS.FE:FindFirstChild("Store") then
            local store = WS.FE.Store
            for _, name in ipairs({"InstantStamina", "Stamina1", "Stamina2"}) do
                if store:FindFirstChild(name) then
                    table.insert(staminaRemotes, store[name])
                end
            end
        end

        if RS:FindFirstChild("FE") then
            local fe = RS.FE
            for _, name in ipairs({"CheckDoneStamina", "InstantStamina", "InstantStaminaA", "InstantStaminaB", "StaminaUpdate", "Sprint"}) do
                if fe:FindFirstChild(name) then
                    table.insert(staminaRemotes, fe[name])
                end
            end
        end

        local mt2 = getrawmetatable(game)
        setreadonly(mt2, false)
        local oldNamecall = mt2.__namecall
        mt2.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            for _, remote in ipairs(staminaRemotes) do
                if self == remote and method == "FireServer" then
                    return
                end
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt2, true)

        local mouse = player:GetMouse()
        mouse.Button1Down:Connect(function() humanoid.WalkSpeed = 22 end)
        mouse.KeyDown:Connect(function(key) if key:lower() == "r" then humanoid.WalkSpeed = 14 end end)

        -- Rayfield bildirimi
        Rayfield:Notify({
            Title = "Boost",
            Content = "Unlimited Stamina Opened",
            Duration = 5,
            Image = 4483362458
        })
    end
})

BoostTab:CreateButton({
    Name = "Stamina Add",
    Callback = function()
        local args = {
            [1] = 1355887714,
            [2] = "SkillG",
            [3] = false
        }

        workspace:WaitForChild("FE"):WaitForChild("PlayerCard"):WaitForChild("Boost"):FireServer(unpack(args))
    end
})

-- Others Bölümü
local OthersBoostSection = BoostTab:CreateSection("Others")
BoostTab:CreateButton({
    Name = "Shoot Power Add",
    Callback = function()
        local args = {
            [1] = 1355887714,
            [2] = "SkillA",
            [3] = false
        }

        workspace:WaitForChild("FE"):WaitForChild("PlayerCard"):WaitForChild("Boost"):FireServer(unpack(args))
    end
})
BoostTab:CreateButton({
    Name = "Pass Power Add",
    Callback = function()
        local args = {
            [1] = 1355887714,
            [2] = "SkillB",
            [3] = false
        }
        workspace:WaitForChild("FE"):WaitForChild("PlayerCard"):WaitForChild("Boost"):FireServer(unpack(args))
    end
})
BoostTab:CreateButton({
    Name = "Curve Power Add",
    Callback = function()
        local args = {
            [1] = 1355887714,
            [2] = "SkillC",
            [3] = false
        }
        workspace:WaitForChild("FE"):WaitForChild("PlayerCard"):WaitForChild("Boost"):FireServer(unpack(args))
    end
})
BoostTab:CreateButton({
    Name = "Tackle Power Add",
    Callback = function()
        local args = {
            [1] = 1355887714,
            [2] = "SkillD",
            [3] = false
        }
        workspace:WaitForChild("FE"):WaitForChild("PlayerCard"):WaitForChild("Boost"):FireServer(unpack(args))
    end
})
BoostTab:CreateButton({
    Name = "Skill Power Add",
    Callback = function()
        local args = {
            [1] = 1355887714,
            [2] = "SkillE",
            [3] = false
        }
        workspace:WaitForChild("FE"):WaitForChild("PlayerCard"):WaitForChild("Boost"):FireServer(unpack(args))
    end
})
BoostTab:CreateButton({
    Name = "GK Power Add",
    Callback = function()
        local args = {
            [1] = 1355887714,
            [2] = "SkillF",
            [3] = false
        }
        workspace:WaitForChild("FE"):WaitForChild("PlayerCard"):WaitForChild("Boost"):FireServer(unpack(args))
    end
})
BoostTab:CreateButton({
    Name = "Durability Add",
    Callback = function()
        local args = {
            [1] = 1355887714,
            [2] = "SkillH",
            [3] = false
        }
        workspace:WaitForChild("FE"):WaitForChild("PlayerCard"):WaitForChild("Boost"):FireServer(unpack(args))
    end
})

-- =======================
-- Clumsy Sekmesi
-- =======================
local ClumsyTab = Window:CreateTab("Clumsy", "shuffle")
local ClumsySection = ClumsyTab:CreateSection("Clumsy")
ClumsyTab:CreateInput({Name = "Clumsy Value", PlaceholderText = "Write number", CurrentValue = "1", Flag = "ClumsyValue", Callback = function(val) print("Clumsy Value:", val) end})

-- Miscellaneous Sekmesi
-- =======================
local MiscTab = Window:CreateTab("Miscellaneous", "settings")
local MiscSection1 = MiscTab:CreateSection("Misc Options")

-- FTP 
local function ToggleFTPRange(enabled)
    if enabled then
        local FTP1 = Instance.new("Part")
        FTP1.Parent = workspace
        FTP1.Size = Vector3.new(155.2, 1, 21.2)
        FTP1.Anchored = true
        FTP1.Transparency = 0.6
        FTP1.CanCollide = false
        FTP1.BrickColor = BrickColor.new("Dark indigo")
        FTP1.Position = Vector3.new(0, 171.9, 130.9)
        FTP1.Name = "FTP1"

        local FTP2 = Instance.new("Part")
        FTP2.Parent = workspace
        FTP2.Size = Vector3.new(155.2, 1, 21.2)
        FTP2.Anchored = true
        FTP2.Transparency = 0.6
        FTP2.CanCollide = false
        FTP2.BrickColor = BrickColor.new("Dark indigo")
        FTP2.Position = Vector3.new(0, 171.9, 425.1)
        FTP2.Name = "FTP2"

        -- Outline 1
        local O11 = Instance.new("Part")
        O11.Parent = FTP1
        O11.Size = Vector3.new(0.4, 0.2, 21.2)
        O11.Anchored = true
        O11.BrickColor = BrickColor.new("White")
        O11.Material = Enum.Material.Neon
        O11.Position = Vector3.new(-77.4, 172.3, 130.9)
        O11.Name = "Outline1.1"

        local O12 = Instance.new("Part")
        O12.Parent = FTP1
        O12.Size = Vector3.new(0.4, 0.2, 21.2)
        O12.Anchored = true
        O12.BrickColor = BrickColor.new("White")
        O12.Material = Enum.Material.Neon
        O12.Position = Vector3.new(77.8, 172.3, 130.9)
        O12.Name = "Outline1.2"

        local O13 = Instance.new("Part")
        O13.Parent = FTP1
        O13.Size = Vector3.new(0.4, 0.2, 155.6)
        O13.Anchored = true
        O13.BrickColor = BrickColor.new("White")
        O13.Material = Enum.Material.Neon
        O13.Position = Vector3.new(0.2, 172.3, 141.5)
        O13.Name = "Outline1.3"
        O13.Orientation = Vector3.new(0, 90, 0)

        -- Outline 2
        local O21 = Instance.new("Part")
        O21.Parent = FTP2
        O21.Size = Vector3.new(0.4, 0.2, 21.2)
        O21.Anchored = true
        O21.BrickColor = BrickColor.new("White")
        O21.Material = Enum.Material.Neon
        O21.Position = Vector3.new(-77.4, 172.3, 425.3)
        O21.Name = "Outline2.1"

        local O22 = Instance.new("Part")
        O22.Parent = FTP2
        O22.Size = Vector3.new(0.4, 0.2, 21.2)
        O22.Anchored = true
        O22.BrickColor = BrickColor.new("White")
        O22.Material = Enum.Material.Neon
        O22.Position = Vector3.new(77.8, 172.3, 425.3)
        O22.Name = "Outline2.2"

        local O23 = Instance.new("Part")
        O23.Parent = FTP2
        O23.Size = Vector3.new(0.4, 0.2, 155.6)
        O23.Anchored = true
        O23.BrickColor = BrickColor.new("White")
        O23.Material = Enum.Material.Neon
        O23.Position = Vector3.new(0.2, 172.3, 414.7)
        O23.Name = "Outline2.3"
        O23.Orientation = Vector3.new(0, 90, 0)
    else
        if workspace:FindFirstChild("FTP1") then workspace.FTP1:Destroy() end
        if workspace:FindFirstChild("FTP2") then workspace.FTP2:Destroy() end
    end
end

local function ToggleTackyRange(enabled)
    if enabled then
        local TACKY1 = Instance.new("Part")
        TACKY1.Parent = workspace
        TACKY1.Size = Vector3.new(216.8, 1, 21.2)
        TACKY1.Anchored = true
        TACKY1.Transparency = 0.6
        TACKY1.CanCollide = false
        TACKY1.BrickColor = BrickColor.new("Lime green")
        TACKY1.Position = Vector3.new(0, 171.9, 425.1)
        TACKY1.Name = "TACKY1"

        local TACKY12 = Instance.new("Part")
        TACKY12.Parent = TACKY1
        TACKY12.Size = Vector3.new(30.8, 1, 58.8)
        TACKY12.Anchored = true
        TACKY12.Transparency = 0.6
        TACKY12.CanCollide = false
        TACKY12.BrickColor = BrickColor.new("Lime green")
        TACKY12.Position = Vector3.new(93.4, 171.9, 465.1)
        TACKY12.Name = "TACKY12"

        local TACKY123 = Instance.new("Part")
        TACKY123.Parent = TACKY1
        TACKY123.Size = Vector3.new(30.8, 1, 58.8)
        TACKY123.Anchored = true
        TACKY123.Transparency = 0.6
        TACKY123.CanCollide = false
        TACKY123.BrickColor = BrickColor.new("Lime green")
        TACKY123.Position = Vector3.new(-92.6, 171.9, 465.1)
        TACKY123.Name = "TACKY123"

        -- Outline T1
        local T21 = Instance.new("Part")
        T21.Parent = TACKY1
        T21.Size = Vector3.new(0.4, 0.2, 80)
        T21.Anchored = true
        T21.BrickColor = BrickColor.new("White")
        T21.Material = Enum.Material.Neon
        T21.Position = Vector3.new(-108, 172.3, 454.7)
        T21.Name = "Outline2.1"

        local T22 = Instance.new("Part")
        T22.Parent = TACKY1
        T22.Size = Vector3.new(0.4, 0.2, 80)
        T22.Anchored = true
        T22.BrickColor = BrickColor.new("White")
        T22.Material = Enum.Material.Neon
        T22.Position = Vector3.new(108.8, 172.3, 454.7)
        T22.Name = "Outline2.2"

        local T23 = Instance.new("Part")
        T23.Parent = TACKY1
        T23.Size = Vector3.new(0.4, 0.2, 217)
        T23.Anchored = true
        T23.BrickColor = BrickColor.new("White")
        T23.Material = Enum.Material.Neon
        T23.Position = Vector3.new(0.3, 172.3, 414.7)
        T23.Name = "Outline2.3"
        T23.Orientation = Vector3.new(0, 90, 0)

        -- =========================
        --  TACKY2
        -- =========================
        local TACKY2 = Instance.new("Part")
        TACKY2.Parent = workspace
        TACKY2.Size = Vector3.new(216.8, 1, 21.2)
        TACKY2.Anchored = true
        TACKY2.Transparency = 0.6
        TACKY2.CanCollide = false
        TACKY2.BrickColor = BrickColor.new("Lime green")
        TACKY2.Position = Vector3.new(0, 171.9, 130.7)
        TACKY2.Name = "TACKY2"
        TACKY2.Orientation = Vector3.new(0, 180, 0)

        local TACKY22 = Instance.new("Part")
        TACKY22.Parent = TACKY2
        TACKY22.Size = Vector3.new(30.8, 1, 58.8)
        TACKY22.Anchored = true
        TACKY22.Transparency = 0.6
        TACKY22.CanCollide = false
        TACKY22.BrickColor = BrickColor.new("Lime green")
        TACKY22.Position = Vector3.new(-93.4, 171.9, 90.7)
        TACKY22.Name = "TACKY22"
        TACKY22.Orientation = Vector3.new(0, 180, 0)

        local TACKY223 = Instance.new("Part")
        TACKY223.Parent = TACKY2
        TACKY223.Size = Vector3.new(30.8, 1, 58.8)
        TACKY223.Anchored = true
        TACKY223.Transparency = 0.6
        TACKY223.CanCollide = false
        TACKY223.BrickColor = BrickColor.new("Lime green")
        TACKY223.Position = Vector3.new(92.6, 171.9, 90.7)
        TACKY223.Name = "TACKY223"
        TACKY223.Orientation = Vector3.new(0, 180, 0)

        -- Outline T2
        local T11 = Instance.new("Part")
        T11.Parent = TACKY2
        T11.Size = Vector3.new(0.4, 0.2, 80)
        T11.Anchored = true
        T11.BrickColor = BrickColor.new("White")
        T11.Material = Enum.Material.Neon
        T11.Position = Vector3.new(108, 172.3, 101.1)
        T11.Name = "Outline2.1"
        T11.Orientation = Vector3.new(0, 180, 0)

        local T12 = Instance.new("Part")
        T12.Parent = TACKY2
        T12.Size = Vector3.new(0.4, 0.2, 80)
        T12.Anchored = true
        T12.BrickColor = BrickColor.new("White")
        T12.Material = Enum.Material.Neon
        T12.Position = Vector3.new(-108.8, 172.3, 101.1)
        T12.Name = "Outline2.2"
        T12.Orientation = Vector3.new(0, 180, 0)

        local T13 = Instance.new("Part")
        T13.Parent = TACKY2
        T13.Size = Vector3.new(0.4, 0.2, 217)
        T13.Anchored = true
        T13.BrickColor = BrickColor.new("White")
        T13.Material = Enum.Material.Neon
        T13.Position = Vector3.new(-0.3, 172.3, 141.1)
        T13.Name = "Outline2.3"
        T13.Orientation = Vector3.new(0, -90, 0)
    else
        if workspace:FindFirstChild("TACKY1") then workspace.TACKY1:Destroy() end
        if workspace:FindFirstChild("TACKY2") then workspace.TACKY2:Destroy() end
    end
end

MiscTab:CreateToggle({
    Name = "FTP Range",
    CurrentValue = false,
    Flag = "FTPRange",
    Callback = function(val)
        ToggleFTPRange(val)
    end
})

MiscTab:CreateToggle({
    Name = "Tacky Range",
    CurrentValue = false,
    Flag = "TackyRange",
    Callback = function(val)
        ToggleTackyRange(val)
    end
})

MiscTab:CreateSlider({
    Name = "FOV",
    Range = {50, 120}, -- artık 50 ile 120 arasında
    Increment = 1,
    CurrentValue = 70,
    Flag = "FOV",
    Callback = function(val)
        if workspace.CurrentCamera then
            workspace.CurrentCamera.FieldOfView = val
        end
    end
})


-- Konfigürasyonu Yükle/Kaydet
Rayfield:LoadConfiguration()
