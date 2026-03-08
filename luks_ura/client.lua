local ESX = exports['es_extended']:getSharedObject()
local isOpen = false

local function closePanel()
    isOpen = false
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)
    SendNUIMessage({ action = "hide" })
end
local function openPanel()
    isOpen = true
    SetNuiFocus(true, false)
    SetNuiFocusKeepInput(true)
    SendNUIMessage({ action = "show" })
    local timer = GetGameTimer()
    CreateThread(function()
        Wait(1000)
        if isOpen then
            closePanel()
        end
    end)
end
RegisterCommand("uraToggle", function()
    if isOpen then closePanel() else openPanel() end
end)

RegisterKeyMapping("uraToggle", "Open Panel", "keyboard", "L")

CreateThread(function()
    while true do
        if isOpen then
            if IsControlJustPressed(0, 0) or IsControlJustPressed(0, 177) then
                closePanel()
            end
        end
        Wait(0)
    end
end)

RegisterNUICallback("close", function()
    closePanel()
end)


AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

AddEventHandler('esx:setJob', function(job)
    if ESX.PlayerData then ESX.PlayerData.job = job end
end)

CreateThread(function()
    while true do

ESX.TriggerServerCallback('luks_ura:getStatus', function(data)
    if not data then return end

    SendNUIMessage({
        action = "update",
        cash = data.cash,
        bank = data.bank,
        id   = data.id,
        job  = data.job,
        rank = data.rank
    })
end)
 Wait(1000)
    end
end)
