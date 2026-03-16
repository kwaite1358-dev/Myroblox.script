-- مكتبة الواجهة (Orion Library)
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- إنشاء النافذة الرئيسية
local Window = OrionLib:MakeWindow({Name = "Car Sales 2 | Script Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "CarSales2"})

-- [[ تبويب الرئيسية ]]
local MainTab = Window:MakeTab({
	Name = "الرئيسية",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- ميزة الـ ESP (كاشف السيارات)
MainTab:AddButton({
	Name = "تفعيل كاشف السيارات (ESP)",
	Callback = function()
        for _, car in pairs(workspace:GetDescendants()) do
            -- فحص إذا كان الموديل سيارة (حسب نظام ماب Car Sales 2)
            if car:IsA("Model") and (car:FindFirstChild("Stats") or car:FindFirstChild("Owner")) then
                if not car:FindFirstChild("CarESP") then
                    local billboard = Instance.new("BillboardGui", car)
                    billboard.Name = "CarESP"
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.Adornee = car.PrimaryPart
                    billboard.AlwaysOnTop = true
                    
                    local label = Instance.new("TextLabel", billboard)
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.TextColor3 = Color3.fromRGB(255, 255, 0)
                    label.TextStrokeTransparency = 0
                    label.TextScaled = true
                    label.Text = car.Name
                end
            end
        end
        OrionLib:MakeNotification({Name = "السكربت", Content = "تم تفعيل كاشف السيارات!", Time = 3})
  	end    
})

-- [[ تبويب الانتقال السريع ]]
local TPTab = Window:MakeTab({
	Name = "انتقال",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

TPTab:AddButton({
	Name = "انتقال لأقرب سيارة",
	Callback = function()
        local player = game.Players.LocalPlayer
        for _, car in pairs(workspace:GetDescendants()) do
            if car:IsA("VehicleSeat") then
                player.Character:SetPrimaryPartCFrame(car.CFrame)
                task.wait(0.1)
                car:Sit(player.Character.Humanoid)
                break
            end
        end
  	end    
})

-- [[ تبويب اللاعب ]]
local PlayerTab = Window:MakeTab({
	Name = "اللاعب",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

PlayerTab:AddSlider({
	Name = "سرعة المشي",
	Min = 16,
	Max = 300,
	Default = 16,
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

OrionLib:Init()
