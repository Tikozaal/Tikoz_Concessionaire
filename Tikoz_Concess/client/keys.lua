ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local open = true

keyRegister("clefvoiture", "Cle voiture", "U", function()

    local coords = GetEntityCoords(PlayerPedId())

    local vehicle, distance = ESX.Game.GetClosestVehicle({
        x = coords.x,
        y = coords.y,
        z = coords.z
    })

    local test = ESX.Game.GetVehicleProperties(vehicle)

    if distance <= 5.0 then

        ESX.TriggerServerCallback("Tikoz/getownedveh", function(owned)

            if owned then

                if open == true then

                    ESX.Streaming.RequestAnimDict("anim@mp_player_intmenu@key_fob@", function()

                        TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                        
                        SetVehicleDoorsLocked(vehicle, 2)
                        SetVehicleEngineOn(vehicle, true, true, false)
                        Wait(300)
                        SetVehicleEngineOn(vehicle, false, false, false)
                        ESX.ShowNotification("Vous venez de ~b~fermer~s~ votre voiture")
                      
                    end)

                    open = false

                elseif open == false then

                    ESX.Streaming.RequestAnimDict("anim@mp_player_intmenu@key_fob@", function()

                        TaskPlayAnim(PlayerPedId(), "anim@mp_player_intmenu@key_fob@", "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
                        
                        SetVehicleDoorsLocked(vehicle, 1)
                        SetVehicleEngineOn(vehicle, true, true, false)
                        Wait(300)
                        SetVehicleEngineOn(vehicle, false, false, false)

                        ESX.ShowNotification("Vous venez d'~g~ouvrir~s~ votre voiture")
                        
                    end)
                    open = true

                end
            end
        end, test.plate)

    end
end)
