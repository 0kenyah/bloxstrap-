return function(title)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BloxstrapGui"
    ScreenGui.ResetOnSpawn = false

    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.fromScale(0.3, 0.3)
    Frame.Position = UDim2.fromScale(0.35, 0.35)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

    local Text = Instance.new("TextLabel", Frame)
    Text.Size = UDim2.fromScale(1, 0.2)
    Text.Text = title or "Bloxstrap"
    Text.TextColor3 = Color3.new(1,1,1)
    Text.BackgroundTransparency = 1
    Text.TextScaled = true

    ScreenGui.Parent = game:GetService("CoreGui")

    return ScreenGui
end
