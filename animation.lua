local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WaietMenu"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local function isMobile()
    return game:GetService("UserInputService").TouchEnabled
end

local function isTablet()
    local viewport = workspace.CurrentCamera.ViewportSize
    local aspectRatio = viewport.X / viewport.Y
    return isMobile() and aspectRatio > 1.2 and aspectRatio < 1.8
end

local function getMenuSize()
    local isPhone = isMobile() and not isTablet()
    if isPhone then
        return UDim2.new(0, 280, 0, 50)
    elseif isTablet() then
        return UDim2.new(0, 320, 0, 50)
    else
        return UDim2.new(0, 350, 0, 50)
    end
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = getMenuSize()
MainFrame.Position = UDim2.new(0.5, -140, 0.4, 0) 
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 1
MainFrame.BorderColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Parent = ScreenGui

local DragButton = Instance.new("TextButton")
DragButton.Name = "DragButton"
DragButton.Size = UDim2.new(1, 0, 1, 0)
DragButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
DragButton.Text = ""
DragButton.AutoButtonColor = false
DragButton.BorderSizePixel = 1
DragButton.BorderColor3 = Color3.fromRGB(50, 50, 50)
DragButton.ZIndex = 1 
DragButton.Parent = MainFrame

local LeftSide = Instance.new("Frame")
LeftSide.Name = "LeftSide"
LeftSide.Size = UDim2.new(0.7, 0, 1, 0)
LeftSide.BackgroundTransparency = 1
LeftSide.ZIndex = 2 -- Đặt cao hơn DragButton
LeftSide.Parent = DragButton

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Text = "ωαιت" 
Title.Size = UDim2.new(1, -10, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20 -- Tăng size tí cho rõ
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 3 
Title.Parent = LeftSide

local RightSide = Instance.new("Frame")
RightSide.Name = "RightSide"
RightSide.Size = UDim2.new(0.3, 0, 1, 0)
RightSide.Position = UDim2.new(0.7, 0, 0, 0)
RightSide.BackgroundTransparency = 1
RightSide.Parent = DragButton

local Arrow = Instance.new("TextLabel")
Arrow.Name = "Arrow"
Arrow.Text = "▼"
Arrow.Size = UDim2.new(1, 0, 1, 0)
Arrow.BackgroundTransparency = 1
Arrow.TextColor3 = Color3.fromRGB(0, 170, 255)
Arrow.TextSize = 20
Arrow.Font = Enum.Font.GothamBold
Arrow.TextXAlignment = Enum.TextXAlignment.Right
Arrow.Parent = RightSide

local MainContent = Instance.new("Frame")
MainContent.Name = "MainContent"
MainContent.Size = UDim2.new(1, 0, 0, 0)
MainContent.Position = UDim2.new(0, 0, 1, 0)
MainContent.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainContent.BorderSizePixel = 1
MainContent.BorderColor3 = Color3.fromRGB(40, 40, 40)
MainContent.ClipsDescendants = true
MainContent.Visible = false

local CategoryItem = Instance.new("TextButton")
CategoryItem.Name = "CategoryItem"
CategoryItem.Text = ""
CategoryItem.Size = UDim2.new(1, -10, 0, 45)
CategoryItem.Position = UDim2.new(0, 5, 0, 5)
CategoryItem.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CategoryItem.AutoButtonColor = true
CategoryItem.BorderSizePixel = 1
CategoryItem.BorderColor3 = Color3.fromRGB(50, 50, 50)

local CategoryLeft = Instance.new("Frame")
CategoryLeft.Name = "CategoryLeft"
CategoryLeft.Size = UDim2.new(0.8, 0, 1, 0)
CategoryLeft.BackgroundTransparency = 1
CategoryLeft.Parent = CategoryItem

local CategoryIcon = Instance.new("TextLabel")
CategoryIcon.Name = "CategoryIcon"
CategoryIcon.Text = "🎭"
CategoryIcon.Size = UDim2.new(0, 30, 1, 0)
CategoryIcon.BackgroundTransparency = 1
CategoryIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
CategoryIcon.TextSize = 18
CategoryIcon.Font = Enum.Font.Gotham
CategoryIcon.TextXAlignment = Enum.TextXAlignment.Center
CategoryIcon.Parent = CategoryLeft

local CategoryText = Instance.new("TextLabel")
CategoryText.Name = "CategoryText"
CategoryText.Text = "Animation"
CategoryText.Size = UDim2.new(1, -40, 1, 0)
CategoryText.Position = UDim2.new(0, 40, 0, 0)
CategoryText.BackgroundTransparency = 1
CategoryText.TextColor3 = Color3.fromRGB(255, 255, 255)
CategoryText.TextSize = 16
CategoryText.Font = Enum.Font.Gotham
CategoryText.TextXAlignment = Enum.TextXAlignment.Left
CategoryText.Parent = CategoryLeft

local CategoryRight = Instance.new("Frame")
CategoryRight.Name = "CategoryRight"
CategoryRight.Size = UDim2.new(0.2, 0, 1, 0)
CategoryRight.Position = UDim2.new(0.8, 0, 0, 0)
CategoryRight.BackgroundTransparency = 1
CategoryRight.Parent = CategoryItem

local CategoryArrow = Instance.new("TextLabel")
CategoryArrow.Name = "CategoryArrow"
CategoryArrow.Text = ">"
CategoryArrow.Size = UDim2.new(1, 0, 1, 0)
CategoryArrow.BackgroundTransparency = 1
CategoryArrow.TextColor3 = Color3.fromRGB(0, 170, 255)
CategoryArrow.TextSize = 22
CategoryArrow.Font = Enum.Font.GothamBold
CategoryArrow.TextXAlignment = Enum.TextXAlignment.Right
CategoryArrow.Parent = CategoryRight

local AnimationContent = Instance.new("Frame")
AnimationContent.Name = "AnimationContent"
AnimationContent.Size = UDim2.new(1, -10, 0, 0)
AnimationContent.Position = UDim2.new(0, 5, 0, 55)
AnimationContent.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
AnimationContent.BorderSizePixel = 1
AnimationContent.BorderColor3 = Color3.fromRGB(50, 50, 50)
AnimationContent.ClipsDescendants = true
AnimationContent.Visible = false

local AnimationList = Instance.new("ScrollingFrame")
AnimationList.Name = "AnimationList"
AnimationList.Size = UDim2.new(1, -10, 1, -10)
AnimationList.Position = UDim2.new(0, 5, 0, 5)
AnimationList.BackgroundTransparency = 1
AnimationList.BorderSizePixel = 0
AnimationList.ScrollBarThickness = 4
AnimationList.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
AnimationList.AutomaticCanvasSize = Enum.AutomaticSize.Y
AnimationList.Parent = AnimationContent

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = AnimationList

CategoryItem.Parent = MainContent
AnimationContent.Parent = MainContent
MainContent.Parent = MainFrame
DragButton.Parent = MainFrame

local Scripts = {
    "loadstring(game:HttpGet('https://pastefy.app/KtyICG4Z/raw'))()",
    "loadstring(game:HttpGet('https://pastefy.app/7ZNk0nbp/raw'))()",
    "loadstring(game:HttpGet('https://pastefy.app/6Q2slYVK/raw'))()",
    "loadstring(game:HttpGet('https://pastefy.app/KdXeLalA/raw'))()",
    "loadstring(game:HttpGet('https://pastefy.app/gRuR1dY9/raw'))()",
    "loadstring(game:HttpGet('https://pastefy.app/rjBJDr0C/raw'))()",
    "loadstring(game:HttpGet('https://pastefy.app/2T5Xwssu/raw'))()"
}

local ButtonNames = {
    "ninja",
    "ông già:))",
    "ma cà rồn", 
    "del biết",
    "del biết 2",
    "chịu:))",
    "zombiee"
}

for i = 1, 7 do
    local ItemButton = Instance.new("TextButton")
    ItemButton.Name = "Item"..i
    ItemButton.Text = ButtonNames[i]  -- HIỆN TÊN TRỰC TIẾP
    ItemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ItemButton.TextSize = 14
    ItemButton.Font = Enum.Font.Gotham
    ItemButton.TextXAlignment = Enum.TextXAlignment.Left
    ItemButton.Size = UDim2.new(1, 0, 0, 38)
    ItemButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ItemButton.AutoButtonColor = true
    ItemButton.BorderSizePixel = 1
    ItemButton.BorderColor3 = Color3.fromRGB(60, 60, 60)
    
    local ItemPadding = Instance.new("UIPadding")
    ItemPadding.PaddingLeft = UDim.new(0, 10)
    ItemPadding.Parent = ItemButton
    
    local ItemRight = Instance.new("Frame")
    ItemRight.Name = "ItemRight"
    ItemRight.Size = UDim2.new(0.2, 0, 1, 0)
    ItemRight.Position = UDim2.new(0.8, 0, 0, 0)
    ItemRight.BackgroundTransparency = 1
    ItemRight.Parent = ItemButton
    
    local ItemIcon = Instance.new("TextLabel")
    ItemIcon.Name = "ItemIcon"
    ItemIcon.Text = ">"
    ItemIcon.Size = UDim2.new(1, 0, 1, 0)
    ItemIcon.BackgroundTransparency = 1
    ItemIcon.TextColor3 = Color3.fromRGB(0, 170, 255)
    ItemIcon.TextSize = 16
    ItemIcon.Font = Enum.Font.GothamBold
    ItemIcon.TextXAlignment = Enum.TextXAlignment.Right
    ItemIcon.Parent = ItemRight
    
    ItemButton.MouseButton1Click:Connect(function()
        ItemButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        ItemButton.BorderColor3 = Color3.fromRGB(0, 170, 255)
        
        pcall(function()
            loadstring(Scripts[i])()
        end)
        
        task.wait(0.1)
        ItemButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        ItemButton.BorderColor3 = Color3.fromRGB(60, 60, 60)
    end)
    
    ItemButton.MouseEnter:Connect(function()
        ItemButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)
    
    ItemButton.MouseLeave:Connect(function()
        ItemButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end)
    
    ItemButton.Parent = AnimationList
end

local mainOpen = false
local categoryOpen = false

local function toggleMainDropdown()
    mainOpen = not mainOpen
    
    if mainOpen then
        MainContent.Visible = true
        Arrow.Text = "▲"
        
        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        if categoryOpen then
            local totalHeight = #AnimationList:GetChildren() * 44
            local targetHeight = 55 + math.min(totalHeight, 300) + 10
            local tween1 = tweenService:Create(MainContent, tweenInfo, {Size = UDim2.new(1, 0, 0, targetHeight)})
            tween1:Play()
        else
            local tween1 = tweenService:Create(MainContent, tweenInfo, {Size = UDim2.new(1, 0, 0, 55)})
            tween1:Play()
        end
    else
        Arrow.Text = "▼"
        
        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = tweenService:Create(MainContent, tweenInfo, {Size = UDim2.new(1, 0, 0, 0)})
        
        tween.Completed:Connect(function()
            if not mainOpen then
                MainContent.Visible = false
            end
        end)
        tween:Play()
    end
end

local function toggleCategory()
    categoryOpen = not categoryOpen
    
    if categoryOpen then
        CategoryArrow.Text = "▼"
        AnimationContent.Visible = true
        
        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        
        local totalHeight = #AnimationList:GetChildren() * 44
        local tween1 = tweenService:Create(AnimationContent, tweenInfo, {Size = UDim2.new(1, -10, 0, math.min(totalHeight, 300))})
        tween1:Play()
        
        if mainOpen then
            wait(0.1)
            local newHeight = 55 + math.min(totalHeight, 300) + 10
            local tween2 = tweenService:Create(MainContent, tweenInfo, {Size = UDim2.new(1, 0, 0, newHeight)})
            tween2:Play()
        end
    else
        CategoryArrow.Text = ">"
        
        local tweenService = game:GetService("TweenService")
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = tweenService:Create(AnimationContent, tweenInfo, {Size = UDim2.new(1, -10, 0, 0)})
        
        tween.Completed:Connect(function()
            if not categoryOpen then
                AnimationContent.Visible = false
            end
        end)
        tween:Play()
        
        if mainOpen then
            wait(0.1)
            local tween2 = tweenService:Create(MainContent, tweenInfo, {Size = UDim2.new(1, 0, 0, 55)})
            tween2:Play()
        end
    end
end

local clickTime = 0
local isDragging = false

DragButton.MouseButton1Down:Connect(function()
    clickTime = tick()
end)

DragButton.MouseButton1Up:Connect(function()
    if tick() - clickTime < 0.3 and not isDragging then
        toggleMainDropdown()
    end
end)

CategoryItem.MouseButton1Click:Connect(function()
    if mainOpen then
        toggleCategory()
    end
end)

local dragging = false
local dragStart = Vector2.new(0, 0)
local frameStart = Vector2.new(0, 0)

local function updateDrag(input)
    if not dragging then return end
    
    local delta = input.Position - dragStart
    local newX = frameStart.X + delta.X
    local newY = frameStart.Y + delta.Y
    
    -- Giới hạn trong màn hình
    local viewport = workspace.CurrentCamera.ViewportSize
    newX = math.clamp(newX, 0, viewport.X - MainFrame.AbsoluteSize.X)
    newY = math.clamp(newY, 0, viewport.Y - MainFrame.AbsoluteSize.Y)
    
    MainFrame.Position = UDim2.new(0, newX, 0, newY)
    isDragging = true
end

DragButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        isDragging = false
        dragStart = input.Position
        frameStart = Vector2.new(MainFrame.Position.X.Offset, MainFrame.Position.Y.Offset)
        DragButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    end
end)

DragButton.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateDrag(input)
    end
end)

-- Kết thúc kéo
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            dragging = false
            DragButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            task.wait(0.1)
            isDragging = false
        end
    end
end)

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
    MainFrame.Size = getMenuSize()
    
    local viewport = workspace.CurrentCamera.ViewportSize
    local currentPos = MainFrame.Position
    
    local maxX = viewport.X - MainFrame.AbsoluteSize.X
    local maxY = viewport.Y - MainFrame.AbsoluteSize.Y
    
    local newX = math.clamp(currentPos.X.Offset, 0, maxX)
    local newY = math.clamp(currentPos.Y.Offset, 0, maxY)
    
    MainFrame.Position = UDim2.new(0, newX, 0, newY)
end)
