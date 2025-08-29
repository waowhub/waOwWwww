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

BoostTab:CreateButton({Name = "Stamina Add", Callback = function() print("Stamina Add clicked") end})

-- Others Bölümü
local OthersBoostSection = BoostTab:CreateSection("Others")
BoostTab:CreateButton({Name = "Shoot Power Add", Callback = function() print("Shoot Power Add clicked") end})
BoostTab:CreateButton({Name = "Pass Power Add", Callback = function() print("Pass Power Add clicked") end})
BoostTab:CreateButton({Name = "Curve Power Add", Callback = function() print("Curve Power Add clicked") end})
BoostTab:CreateButton({Name = "Tackle Add", Callback = function() print("Tackle Add clicked") end})
BoostTab:CreateButton({Name = "Skill Power Add", Callback = function() print("Skill Power Add clicked") end})
BoostTab:CreateButton({Name = "GK Power Add", Callback = function() print("GK Power Add clicked") end})
BoostTab:CreateButton({Name = "Durability Add", Callback = function() print("Durability Add clicked") end})

-- =======================
-- Clumsy Sekmesi
-- =======================
local ClumsyTab = Window:CreateTab("Clumsy", "shuffle")
local ClumsySection = ClumsyTab:CreateSection("Clumsy")
ClumsyTab:CreateInput({Name = "Clumsy Value", PlaceholderText = "Write number", CurrentValue = "1", Flag = "ClumsyValue", Callback = function(val) print("Clumsy Value:", val) end})

-- =======================
-- Miscellaneous Sekmesi
-- =======================
local MiscTab = Window:CreateTab("Miscellaneous", "settings")
local MiscSection1 = MiscTab:CreateSection("Misc Options")
MiscTab:CreateToggle({Name = "FTP Range", CurrentValue = false, Flag = "FTPRange", Callback = function(val) print("FTP Range:", val) end})
MiscTab:CreateToggle({Name = "Tacky Range", CurrentValue = false, Flag = "TackyRange", Callback = function(val) print("Tacky Range:", val) end})
MiscTab:CreateSlider({Name = "FOV", Range = {1, 120}, Increment = 1, Suffix = "", CurrentValue = 70, Flag = "FOV", Callback = function(val) print("FOV:", val) end})

-- Konfigürasyonu Yükle/Kaydet
Rayfield:LoadConfiguration()
