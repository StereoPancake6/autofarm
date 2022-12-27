	while true do

repeat
    wait(.5)
until game:IsLoaded()
local gm = getrawmetatable(game)
setreadonly(gm, false)
local namecall = gm.__namecall
gm.__namecall =
    newcclosure(
    function(self, ...)
        local args = {...}
        if not checkcaller() and getnamecallmethod() == "FireServer" and tostring(self) == "MainEvent" then
            if tostring(getcallingscript()) ~= "Framework" then
                return
            end
        end
        if not checkcaller() and getnamecallmethod() == "Kick" then
            return
        end
        return namecall(self, unpack(args))
    end
)

local LocalPlayer = game:GetService("Players").LocalPlayer

function GetTarget()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait(.5)
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    local maxdistance = math.huge
    local target
    for i, v in pairs(game:GetService("Workspace").Cashiers:GetChildren()) do
        if v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local distance = (HumanoidRootPart.Position - v.Head.Position).magnitude
            if distance < maxdistance then
                target = v
                maxdistance = distance
            end
        end
    end
    return target
end

for i, v in pairs(workspace:GetDescendants()) do
    if v:IsA("Seat") then
        v:Destroy()
    end
end

shared.MoneyFarm = true -- Just execute shared.MoneyFarm = false to stop farming

while shared.MoneyFarm do
    wait(.5)
    local Target = GetTarget()
    repeat
        wait(.5)
        pcall(
            function()
                local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait(.5)
                local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                local Combat = LocalPlayer.Backpack:FindFirstChild("Combat") or Character:FindFirstChild("Combat")
                if not Combat then
                    Character:FindFirstChild("Humanoid").Health = 0
                    return
                end
                HumanoidRootPart.CFrame = Target.Head.CFrame * CFrame.new(0, 0, 2)
                Combat.Parent = Character
                Combat:Activate()
            end
        )
    until not Target or Target.Humanoid.Health < 0
    for i, money in ipairs(game.Workspace.Ignored.Drop:GetChildren()) do
        if money.Name == "MoneyDrop" and (money.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 16 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = money.CFrame
            fireclickdetector(money.ClickDetector)
            wait(0.9)
        end  
    end
end

startGetTarget()
	    wait(10)
	end
