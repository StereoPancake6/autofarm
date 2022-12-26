local humanoid = game.Players.LocalPlayer.Character.Humanoid
local tool = game.Players.LocalPlayer.Backpack.Combat

local function getMoneyAroundMe() 
    wait(0.7)
    for i, money in ipairs(game.Workspace.Ignored.Drop:GetChildren()) do
        if money.Name == "MoneyDrop" and (money.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 20 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = money.CFrame
            fireclickdetector(money.ClickDetector)
            wait(0.6)
        end  
    end
end


local function startAutoFarm() 
    humanoid:EquipTool(tool)

    for i, v in ipairs(game.Workspace.Cashiers:GetChildren()) do
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Open.CFrame * CFrame.new(0, 0, 2)

        for i = 0, 15 do
            wait(0.7)
            tool:Activate()
        end

        getMoneyAroundMe()

    end



    wait(0.6)
 
end

startAutoFarm()
