local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remoteEvent =
    ReplicatedStorage:WaitForChild("InventoryRemote")

local AllowedItems = {
    Sword = true,
    Potion = true
}

local PlayerData = {}

local function onInventoryItem(player, item, amount)

    -- Secure Validation
    if not AllowedItems[item] then
        warn("Invalid Item:", item)
        return
    end

    if type(amount) ~= "number" or amount <= 0 then
        warn("Invalid Amount")
        return
    end

    PlayerData[player] = PlayerData[player] or {}

    PlayerData[player][item] =
        (PlayerData[player][item] or 0) + amount

    print(player.Name .. " received " .. item)
end

remoteEvent.OnServerEvent:Connect(onInventoryItem)