local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local Mouse = lp:GetMouse()

_G.InfinityRadius = 5
_G.InfinityEnabled = true
local History = {}

local function ApplyInfinity()
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local myHrp = char.HumanoidRootPart
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Humanoid") then
            local npcChar = obj.Parent
            local npcHrp = npcChar:FindFirstChild("HumanoidRootPart")
            if npcHrp and not Players:GetPlayerFromCharacter(npcChar) then
                local dist = (myHrp.Position - npcHrp.Position).Magnitude
                if dist < _G.InfinityRadius then
                    local direction = (npcHrp.Position - myHrp.Position).Unit
                    local boundaryPos = myHrp.Position + (direction * _G.InfinityRadius)
                    npcHrp.CFrame = CFrame.new(Vector3.new(boundaryPos.X, npcHrp.Position.Y, boundaryPos.Z), Vector3.new(myHrp.Position.X, npcHrp.Position.Y, myHrp.Position.Z))
                    npcHrp.Velocity = Vector3.new(0, 0, 0)
                    for _, part in pairs(npcChar:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanTouch = false
                        elseif part:IsA("TouchTransmitter") then
                            part:Destroy()
                        end
                    end
                end
            end
        end
    end
end

local function SetupF3X()
    local Tool = Instance.new("Tool")
    Tool.Name = "F3X"
    Tool.RequiresHandle = false
    Tool.Parent = lp.Backpack
    local ScreenGui = Instance.new("ScreenGui", lp.PlayerGui)
    ScreenGui.Name = "F3X_Ultimate_Gui"
    ScreenGui.Enabled = false
    local function CreateBtn(name, pos, text, color)
        local btn = Instance.new("TextButton", ScreenGui)
        btn.Name = name
        btn.Size = UDim2.new(0, 35, 0, 35)
        btn.Position = pos
        btn.BackgroundColor3 = color or Color3.fromRGB(0, 0, 0)
        btn.BackgroundTransparency = 0.4
        btn.Text = text; btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold; btn.TextSize = 14
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        return btn
    end
    local CloseBtn = CreateBtn("XBtn", UDim2.new(0.5, -110, 0, 20), "X", Color3.fromRGB(200, 0, 0))
    local MoveBtn  = CreateBtn("MBtn", UDim2.new(0.5, -70, 0, 20), "M")
    local SizeBtn  = CreateBtn("SBtn", UDim2.new(0.5, -30, 0, 20), "S")
    local RotBtn   = CreateBtn("RBtn", UDim2.new(0.5, 10, 0, 20), "R")
    local DelBtn   = CreateBtn("DBtn", UDim2.new(0.5, 50, 0, 20), "D")
    local ResBtn   = CreateBtn("HBtn", UDim2.new(0.5, 90, 0, 20), "H", Color3.fromRGB(0, 150, 0))
    local Selection = Instance.new("SelectionBox", lp.PlayerGui)
    Selection.Color3 = Color3.new(0, 1, 1); Selection.LineThickness = 0.05
    local HandleMove = Instance.new("Handles", lp.PlayerGui)
    local HandleSize = Instance.new("Handles", lp.PlayerGui)
    local HandleRot  = Instance.new("ArcHandles", lp.PlayerGui)
    HandleMove.Style, HandleSize.Style = Enum.HandlesStyle.Movement, Enum.HandlesStyle.Resize
    HandleMove.Visible, HandleSize.Visible, HandleRot.Visible = false, false, false
    local Mode, TargetPart = nil, nil
    local function FixPhysics(part)
        if part and part:IsA("BasePart") then
            part.CanCollide = true; part.Anchored = true
            part.Velocity = Vector3.new(0, 0.01, 0) 
        end
    end
    local function ClearUI()
        HandleMove.Visible, HandleSize.Visible, HandleRot.Visible = false, false, false
        MoveBtn.BackgroundColor3 = Color3.new(0,0,0); MoveBtn.TextColor3 = Color3.new(1,1,1)
        SizeBtn.BackgroundColor3 = Color3.new(0,0,0); SizeBtn.TextColor3 = Color3.new(1,1,1)
        RotBtn.BackgroundColor3  = Color3.new(0,0,0); RotBtn.TextColor3  = Color3.new(1,1,1)
    end
    local function SaveState(part, isDelete)
        if not part then return end
        History[part] = {cf = part.CFrame, sz = part.Size, parent = part.Parent, deleted = isDelete or false}
    end
    CloseBtn.MouseButton1Click:Connect(function() Tool:Destroy(); ScreenGui:Destroy() end)
    MoveBtn.MouseButton1Click:Connect(function() ClearUI(); Mode = "Move"; MoveBtn.BackgroundColor3 = Color3.new(1,1,1); MoveBtn.TextColor3 = Color3.new(0,0,0); if TargetPart then HandleMove.Visible = true end end)
    SizeBtn.MouseButton1Click:Connect(function() ClearUI(); Mode = "Size"; SizeBtn.BackgroundColor3 = Color3.new(1,1,1); SizeBtn.TextColor3 = Color3.new(0,0,0); if TargetPart then HandleSize.Visible = true end end)
    RotBtn.MouseButton1Click:Connect(function() ClearUI(); Mode = "Rotate"; RotBtn.BackgroundColor3 = Color3.new(1,1,1); RotBtn.TextColor3 = Color3.new(0,0,0); if TargetPart then HandleRot.Visible = true end end)
    DelBtn.MouseButton1Click:Connect(function() if TargetPart then SaveState(TargetPart, true); TargetPart.Parent = nil; TargetPart = nil; Selection.Adornee = nil; ClearUI(); Mode = nil end end)
    ResBtn.MouseButton1Click:Connect(function() for part, data in pairs(History) do part.Parent = data.parent; part.CFrame = data.cf; part.Size = data.sz end; History = {} end)
    Mouse.Button1Down:Connect(function()
        if lp.Character:FindFirstChild("F3X") then
            local target = Mouse.Target
            if target and target:IsA("BasePart") then
                TargetPart = target; Selection.Adornee = target; HandleMove.Adornee = target; HandleSize.Adornee = target; HandleRot.Adornee = target
                if Mode == "Move" then ClearUI(); HandleMove.Visible = true; MoveBtn.BackgroundColor3 = Color3.new(1,1,1); MoveBtn.TextColor3 = Color3.new(0,0,0)
                elseif Mode == "Size" then ClearUI(); HandleSize.Visible = true; SizeBtn.BackgroundColor3 = Color3.new(1,1,1); SizeBtn.TextColor3 = Color3.new(0,0,0)
                elseif Mode == "Rotate" then ClearUI(); HandleRot.Visible = true; RotBtn.BackgroundColor3 = Color3.new(1,1,1); RotBtn.TextColor3 = Color3.new(0,0,0) end
            end
        end
    end)
    local lcf, lsz = CFrame.new(), Vector3.new()
    HandleMove.MouseButton1Down:Connect(function() if TargetPart then SaveState(TargetPart); lcf = TargetPart.CFrame end end)
    HandleMove.MouseDrag:Connect(function(id, dist) if TargetPart then TargetPart.CFrame = lcf * CFrame.new(Vector3.FromNormalId(id) * dist); FixPhysics(TargetPart) end end)
    HandleSize.MouseButton1Down:Connect(function() if TargetPart then SaveState(TargetPart); lsz = TargetPart.Size; lcf = TargetPart.CFrame end end)
    HandleSize.MouseDrag:Connect(function(id, dist) if TargetPart then local delta = Vector3.FromNormalId(id) * dist; TargetPart.Size = lsz + delta; TargetPart.CFrame = lcf * CFrame.new(delta/2); FixPhysics(TargetPart) end end)
    HandleRot.MouseButton1Down:Connect(function() if TargetPart then SaveState(TargetPart); lcf = TargetPart.CFrame end end)
    HandleRot.MouseDrag:Connect(function(axis, rel) if TargetPart then TargetPart.CFrame = lcf * CFrame.fromAxisAngle(Vector3.FromAxis(axis), rel); FixPhysics(TargetPart) end end)
    Tool.Equipped:Connect(function() ScreenGui.Enabled = true end)
    Tool.Unequipped:Connect(function() ScreenGui.Enabled = false; ClearUI(); Mode = nil; Selection.Adornee = nil; TargetPart = nil end)
end

RunService.Heartbeat:Connect(function() if _G.InfinityEnabled then ApplyInfinity() end end)
lp.CharacterAdded:Connect(function() task.wait(1); _G.InfinityEnabled = true; SetupF3X() end)
SetupF3X()
print("Ultimate Hybrid Script Loaded.")
