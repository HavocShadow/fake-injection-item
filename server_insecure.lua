local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local remoteEvent = ReplicatedStorage:FindFirstChildOfClass("RemoteEvent")

-- contoh kode server yang salah dan terlalu percaya client
local function onInventoryItem(player, item, amount)
    player.Inventory[item] = (player.Inventory[item] or 0) + amount
end

-- Exploit yang terjadi SwordAdmin = 999999
