function GetMineshaftInventory()
    for _, name in pairs(peripheral.getNames()) do
        if peripheral.hasType(name, "occultism:dimensional_mineshaft") then
            return peripheral.wrap(name)
        end
    end
    return nil
end

function GetDurability(inventory, slot)
    if inventory == nil or slot == nil or inventory.getItemDetail(slot) == nil or inventory.getItemDetail(slot).durability == nil then
        return -1
    end
    return inventory.getItemDetail(slot).durability
end

function IsLowDurability(durability)
    if durability == nil then
        return false
    end
    return durability <= 0.05
end

function TryMoveItem(fromInventory, fromSlot, toInventory)
    if fromInventory == nil or fromSlot == nil or toInventory == nil then
        return false
    else
        fromInventory.pushItems(peripheral.getName(toInventory), fromSlot)
        return true
    end
end

function GetNonShaftAdjacentInventory()
    for _, name in pairs(peripheral.getNames()) do
        if peripheral.hasType(name, "inventory") and not peripheral.hasType(name, "occultism:dimensional_mineshaft") then
            return peripheral.wrap(name)
        end
    end
    return nil
end

function Main()
    while true do
        local mineshaftInventory = GetMineshaftInventory()
        if IsLowDurability(GetDurability(mineshaftInventory, 1)) then
            if TryMoveItem(mineshaftInventory, 1, GetNonShaftAdjacentInventory()) then
                print("Moved item with low durability")
            end
        end
        sleep(20)
    end
end

Main()