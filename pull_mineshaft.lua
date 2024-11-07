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

function MoveItem(fromInventory, fromSlot, toInventory)
    if fromInventory == nil or fromSlot == nil or toInventory == nil then
    else
        fromInventory.pushItems(peripheral.getName(toInventory), fromSlot)
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
            MoveItem(mineshaftInventory, 1, GetNonShaftAdjacentInventory())
            print("Moved item with low durability")
        end
    end
end

Main()