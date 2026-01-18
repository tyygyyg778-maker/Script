local TargetID = 131623223084840
if game.PlaceId ~= TargetID and game.GameId ~= TargetID then return end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer

local HomeCF = CFrame.new(150.13, 12.05, 0.59) 
local PathPoints = {
    Vector3.new(280.20, -2.70, 8.97),
    Vector3.new(396.09, -2.70, 7.20),
    Vector3.new(539.91, -2.70, 8.06),
    Vector3.new(754.22, -2.70, 2.45),
    Vector3.new(1071.53, -2.70, 16.27),
    Vector3.new(1553.12, -2.70, 1.29),
    Vector3.new(2254.17, -2.70, -0.47),
    Vector3.new(2594.12, -2.70, 28.28)
}

local CurrentPointIndex = 1
local AutoForwardActive = false 
local IsMinimized = false
local CurrentSpeed = 150 -- Mặc định 150
local CurrentTween = nil

local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 230, 0, 250) 
Main.Position = UDim2.new(0.5, -115, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(0, 56, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "Hỗ Trợ"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -35, 0, 7)
CloseBtn.Text = "×"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", CloseBtn)

local MinBtn = Instance.new("TextButton", Header)
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -65, 0, 7)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", MinBtn)

local Content = Instance.new("Frame", Main)
Content.Size = UDim2.new(1, 0, 1, -40)
Content.Position = UDim2.new(0, 0, 0, 40)
Content.BackgroundTransparency = 1

-- Chữ hiển thị tốc độ nhỏ và mờ
local SpeedInfo = Instance.new("TextLabel", Content)
SpeedInfo.Size = UDim2.new(1, 0, 0, 15)
SpeedInfo.Position = UDim2.new(0, 0, 0, 2)
SpeedInfo.Text = "Speed: 150"
SpeedInfo.TextColor3 = Color3.fromRGB(150, 150, 150)
SpeedInfo.TextTransparency = 0.4
SpeedInfo.Font = Enum.Font.SourceSans
SpeedInfo.TextSize = 12
SpeedInfo.BackgroundTransparency = 1

local GoHomeBtn = Instance.new("TextButton", Content)
GoHomeBtn.Size = UDim2.new(0, 200, 0, 40)
GoHomeBtn.Position = UDim2.new(0, 15, 0, 18) -- Đẩy xuống dưới nhãn Speed
GoHomeBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 180)
GoHomeBtn.Text = "TP HOME"
GoHomeBtn.TextColor3 = Color3.new(1, 1, 1)
GoHomeBtn.Font = Enum.Font.SourceSansBold
GoHomeBtn.TextSize = 18
Instance.new("UICorner", GoHomeBtn)

local SpeedDown = Instance.new("TextButton", Content)
SpeedDown.Size = UDim2.new(0, 95, 0, 35)
SpeedDown.Position = UDim2.new(0, 15, 0, 65)
SpeedDown.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SpeedDown.Text = "-"
SpeedDown.TextColor3 = Color3.new(1, 1, 1)
SpeedDown.TextSize = 30
Instance.new("UICorner", SpeedDown)

local SpeedUp = Instance.new("TextButton", Content)
SpeedUp.Size = UDim2.new(0, 95, 0, 35)
SpeedUp.Position = UDim2.new(0, 120, 0, 65)
SpeedUp.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SpeedUp.Text = "+"
SpeedUp.TextColor3 = Color3.new(1, 1, 1)
SpeedUp.TextSize = 30
Instance.new("UICorner", SpeedUp)

local AutoBtn = Instance.new("TextButton", Content)
AutoBtn.Size = UDim2.new(0, 200, 0, 40)
AutoBtn.Position = UDim2.new(0, 15, 0, 108)
AutoBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
AutoBtn.Text = "FAST SPEED: OFF"
AutoBtn.TextColor3 = Color3.new(1, 1, 1)
AutoBtn.Font = Enum.Font.SourceSansBold
AutoBtn.TextSize = 18
Instance.new("UICorner", AutoBtn)

local TpFarmBtn = Instance.new("TextButton", Content)
TpFarmBtn.Size = UDim2.new(0, 200, 0, 40)
TpFarmBtn.Position = UDim2.new(0, 15, 0, 155)
TpFarmBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
TpFarmBtn.Text = "TP FARM"
TpFarmBtn.TextColor3 = Color3.new(1, 1, 1)
TpFarmBtn.Font = Enum.Font.SourceSansBold
TpFarmBtn.TextSize = 18
Instance.new("UICorner", TpFarmBtn)

local Credit = Instance.new("TextLabel", Content)
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.Text = "by white"
Credit.TextColor3 = Color3.fromRGB(100, 100, 100)
Credit.Font = Enum.Font.SourceSans
Credit.TextSize = 12
Credit.BackgroundTransparency = 1

-- Hàm cập nhật text speed
local function UpdateSpeedLabel()
    SpeedInfo.Text = "Speed: " .. tostring(CurrentSpeed)
end

lp.CharacterAdded:Connect(function()
    CurrentPointIndex = 1
    if CurrentTween then CurrentTween:Cancel() end
    TpFarmBtn.Text = "TP FARM"
end)

TpFarmBtn.MouseButton1Click:Connect(function()
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if hrp and (not CurrentTween or CurrentTween.PlaybackState ~= Enum.PlaybackState.Playing) then
        local targetPos = PathPoints[CurrentPointIndex]
        local duration = (hrp.Position - targetPos).Magnitude / 200
        TpFarmBtn.Text = "FLYING..."
        CurrentTween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
        CurrentTween:Play()
        CurrentTween.Completed:Connect(function(state)
            if state == Enum.PlaybackState.Completed then
                CurrentPointIndex = (CurrentPointIndex % #PathPoints) + 1
                TpFarmBtn.Text = "TP FARM"
            end
        end)
    end
end)

-- Chỉnh Speed Home: Min 150, Max 700
SpeedUp.MouseButton1Click:Connect(function() 
    CurrentSpeed = math.clamp(CurrentSpeed + 50, 150, 700) 
    UpdateSpeedLabel()
end)
SpeedDown.MouseButton1Click:Connect(function() 
    CurrentSpeed = math.clamp(CurrentSpeed - 50, 150, 700) 
    UpdateSpeedLabel()
end)

GoHomeBtn.MouseButton1Click:Connect(function()
    local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local dist = (hrp.Position - HomeCF.Position).Magnitude
        TweenService:Create(hrp, TweenInfo.new(dist / CurrentSpeed, Enum.EasingStyle.Linear), {CFrame = HomeCF}):Play()
    end
end)

AutoBtn.MouseButton1Click:Connect(function()
    AutoForwardActive = not AutoForwardActive
    AutoBtn.Text = AutoForwardActive and "FAST SPEED: ON" or "FAST SPEED: OFF"
    AutoBtn.BackgroundColor3 = AutoForwardActive and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(45, 45, 45)
end)

RunService.Heartbeat:Connect(function()
    if AutoForwardActive then
        local char = lp.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if hrp and hum and hum.MoveDirection.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -3)
            task.wait(0.06)
        end
    end
end)

task.spawn(function()
    while task.wait(0.3) do
        local char = lp.Character
        if not char or char:FindFirstChildOfClass("Tool") then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, prompt in pairs(workspace:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") and (hrp.Position - prompt.Parent.Position).Magnitude <= prompt.MaxActivationDistance then
                    prompt.HoldDuration = 0
                    fireproximityprompt(prompt)
                    task.wait(0.5)
                    break
                end
            end
        end
    end
end)

MinBtn.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    Main:TweenSize(IsMinimized and UDim2.new(0, 230, 0, 40) or UDim2.new(0, 230, 0, 250), "Out", "Quart", 0.2, true)
    Content.Visible = not IsMinimized
end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local d, s, sp; Header.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then d = true s = i.Position sp = Main.Position end end)
UserInputService.InputChanged:Connect(function(i) if d and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then local delta = i.Position - s Main.Position = UDim2.new(sp.X.Scale, sp.X.Offset + delta.X, sp.Y.Scale, sp.Y.Offset + delta.Y) end end)
UserInputService.InputEnded:Connect(function() d = false end)
