local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local KeySystem = Instance.new("Frame", ScreenGui)
local UICorner = Instance.new("UICorner", KeySystem)
local Title = Instance.new("TextLabel", KeySystem)
local KeyInput = Instance.new("TextBox", KeySystem)
local UICorner2 = Instance.new("UICorner", KeyInput)
local CheckBtn = Instance.new("TextButton", KeySystem)
local UICorner3 = Instance.new("UICorner", CheckBtn)

KeySystem.Name = "KeySystem"
KeySystem.Size = UDim2.new(0, 280, 0, 180)
KeySystem.Position = UDim2.new(0.5, -140, 0.5, -90)
KeySystem.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeySystem.BorderSizePixel = 0
MakeDraggable(KeySystem)

Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "WAI SYSTEM"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold

KeyInput.Size = UDim2.new(0, 220, 0, 45)
KeyInput.Position = UDim2.new(0.5, -110, 0, 60)
KeyInput.PlaceholderText = "Nhập Key..."
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyInput.TextColor3 = Color3.new(1, 1, 1)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextSize = 14

CheckBtn.Size = UDim2.new(0, 220, 0, 40)
CheckBtn.Position = UDim2.new(0.5, -110, 0, 120)
CheckBtn.Text = "Check Key"
CheckBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CheckBtn.TextColor3 = Color3.new(1, 1, 1)
CheckBtn.Font = Enum.Font.GothamBold
CheckBtn.TextSize = 16

CheckBtn.MouseButton1Click:Connect(function()
    local input = string.lower(KeyInput.Text)
    if input == "wai" then
        CheckBtn.Text = "Đúng Key! Đang tải..."
        CheckBtn.BackgroundColor3 = Color3.fromRGB(45, 120, 45)
        task.wait(2)
        ScreenGui:Destroy()
        loadstring(game:HttpGet("https://pastefy.app/FDDMD68F/raw?part=vbb.lua"))()
    else
        CheckBtn.Text = "Sai Key!"
        CheckBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        task.wait(1)
        CheckBtn.Text = "Check Key"
        CheckBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)
