----------------------------------------------------------------
--  _      _    _             _   _               _         _ --
-- | |    / \  | |__   ___   | \ | |_ __ ___  ___| |__     | |--
-- | |   / _ \ | '_ \ / _ \  |  \| | '_ ` _ \/ __| '_ \    | |--
-- |_|_ / ___ \| |_) | (_) | | |\  | | | | | \__ \ | | |_ _|_|--
-- (_|_)_/   \_\_.__/ \___/  |_| \_|_| |_| |_|___/_| |_(_|_|_)--
-- https://discord.gg/rfEs2VvaSd                              --
----------------------------------------------------------------


local xhairActive = false
local disableXhair = false

RegisterNetEvent('hunting:onxhair')
AddEventHandler('hunting:onxhair', function(xhair)
    xhairActive = xhair
end)

RegisterCommand('xhair', function(source, args, raw)
    if args[1] == 'on' then
        xhairActive = true
        disableXhair = false
        SendNUIMessage("xhairShow")
    elseif args[1] == 'off' then
        disableXhair = true
        SendNUIMessage("xhairHide")
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsPauseMenuActive() then
            disableXhair = true
            SendNUIMessage("xhairHide")
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        local ped = PlayerPedId()
        local ped_veh = GetVehiclePedIsIn(ped, false)
        if not disableXhair and not xhairActive and IsPedArmed(ped, 7) then
            xhairActive = true
            SendNUIMessage("xhairShow")
        elseif not IsPedArmed(PlayerPedId(), 7) and xhairActive then
            xhairActive = false
            SendNUIMessage("xhairHide")
        end
    end
end)

----------------------------------------------------------------
--  _      _    _             _   _               _         _ --
-- | |    / \  | |__   ___   | \ | |_ __ ___  ___| |__     | |--
-- | |   / _ \ | '_ \ / _ \  |  \| | '_ ` _ \/ __| '_ \    | |--
-- |_|_ / ___ \| |_) | (_) | | |\  | | | | | \__ \ | | |_ _|_|--
-- (_|_)_/   \_\_.__/ \___/  |_| \_|_| |_| |_|___/_| |_(_|_|_)--
-- https://discord.gg/rfEs2VvaSd                              --
----------------------------------------------------------------