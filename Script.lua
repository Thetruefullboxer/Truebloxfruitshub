-- Blox Fruits Main Hub Loader
print("Blox Fruits Hub Loaded Successfully!")

-- UI Library and script features will be added here next
-- Rayfield Library Loadstring
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Window
local Window = Rayfield:CreateWindow({
   Name = "True Blox Fruits Hub | Keyless",
   LoadingTitle = "True Blox Fruits Hub",
   LoadingSubtitle = "by Thetruefullboxer",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "TrueHubConfig",
      FileName = "BloxFruits"
   },
   Discord = {
      Enabled = false
   },
   KeySystem = false -- Keyless set to true
})

-- Global Variables
_G.AutoFarm = false
_G.FastAttack = false
_G.ESPPlayer = false
_G.ESPFruit = false
_G.AutoStoreFruit = false

-------------------------------------------------------------------
-- TABS
-------------------------------------------------------------------

local MainTab = Window:CreateTab("Auto Farm", 4483362458) -- Title, Image
local CombatTab = Window:CreateTab("Combat & PvP", 4483362458)
local ESPTab = Window:CreateTab("ESP / Visuals", 4483362458)
local TeleportTab = Window:CreateTab("Teleports", 4483362458)
local FruitTab = Window:CreateTab("Fruits & Misc", 4483362458)

-------------------------------------------------------------------
-- 1. AUTO FARM TAB
-------------------------------------------------------------------

MainTab:CreateSection("Level Farming")

local FarmToggle = MainTab:CreateToggle({
   Name = "Auto Farm Level",
   CurrentValue = false,
   Flag = "AutoFarmToggle",
   Callback = function(Value)
      _G.AutoFarm = Value
      if Value then
         Rayfield:Notify({Title = "Auto Farm", Content = "Auto Farm Enabled", Duration = 2})
      end
   end,
})

-- Auto Farm Logic Loop
task.spawn(function()
    while task.wait(0.1) do
        if _G.AutoFarm then
            pcall(function()
                -- Place your targeted NPC quest & attack logic here
                -- Example: Teleporting above nearest mob
            end)
        end
    end
end)

-------------------------------------------------------------------
-- 2. COMBAT TAB
-------------------------------------------------------------------

CombatTab:CreateSection("Attack Modifiers")

CombatTab:CreateToggle({
   Name = "Fast Attack (No Cooldown)",
   CurrentValue = false,
   Flag = "FastAttackToggle",
   Callback = function(Value)
      _G.FastAttack = Value
   end,
})

-- Fast Attack Loop
task.spawn(function()
    while task.wait(0.05) do
        if _G.FastAttack then
            pcall(function()
                local RegisterAttack = game:GetService("ReplicatedStorage").RigControllerEvent
                RegisterAttack:FireServer("weaponHit", {})
            end)
        end
    end
end)

-------------------------------------------------------------------
-- 3. ESP TAB
-------------------------------------------------------------------

ESPTab:CreateSection("Visual Highlights")

ESPTab:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Flag = "PlayerESPToggle",
   Callback = function(Value)
      _G.ESPPlayer = Value
      for _, player in pairs(game.Players:GetPlayers()) do
         if player ~= game.Players.LocalPlayer and player.Character then
            if Value then
               if not player.Character:FindFirstChild("Highlight") then
                  local hl = Instance.new("Highlight", player.Character)
                  hl.FillColor = Color3.fromRGB(255, 0, 0)
               end
            else
               if player.Character:FindFirstChild("Highlight") then
                  player.Character.Highlight:Destroy()
               end
            end
         end
      end
   end,
})

ESPTab:CreateToggle({
   Name = "Fruit ESP",
   CurrentValue = false,
   Flag = "FruitESPToggle",
   Callback = function(Value)
      _G.ESPFruit = Value
      -- Scans Workspace for Devil Fruits
      for _, obj in pairs(game.Workspace:GetChildren()) do
         if string.find(obj.Name, "Fruit") then
            if Value then
               if not obj:FindFirstChild("Highlight") then
                  local hl = Instance.new("Highlight", obj)
                  hl.FillColor = Color3.fromRGB(0, 255, 100)
               end
            else
               if obj:FindFirstChild("Highlight") then
                  obj.Highlight:Destroy()
               end
            end
         end
      end
   end,
})

-------------------------------------------------------------------
-- 4. TELEPORT TAB
-------------------------------------------------------------------

TeleportTab:CreateSection("First Sea Teleports")

TeleportTab:CreateButton({
   Name = "Teleport to Starter Island",
   Callback = function()
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1072, 16, 1423)
   end,
})

TeleportTab:CreateButton({
   Name = "Teleport to Marine Fortress",
   Callback = function()
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4800, 20, 4300)
   end,
})

-------------------------------------------------------------------
-- 5. FRUITS & MISC TAB
-------------------------------------------------------------------

FruitTab:CreateSection("Automated Fruit Helpers")

FruitTab:CreateToggle({
   Name = "Auto Store Fruits",
   CurrentValue = false,
   Flag = "AutoStoreToggle",
   Callback = function(Value)
      _G.AutoStoreFruit = Value
   end,
})

-- Auto Store Loop
task.spawn(function()
    while task.wait(2) do
        if _G.AutoStoreFruit then
            pcall(function()
                for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if string.find(item.Name, "Fruit") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", item.Name, item)
                    end
                end
            end)
        end
    end
end)

Rayfield:Notify({
   Title = "True Hub Loaded",
   Content = "Welcome to True Blox Fruits Hub!",
   Duration = 5,
   Image = 4483362458,
})
