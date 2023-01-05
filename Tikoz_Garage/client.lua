ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

function toPercent(num)
    return (num * 100) / 1000
end

function Keyboardput(TextEntry, ExampleText, MaxStringLength) 
    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

menugarage = {
    Base = {Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 215, 255}, Title = "Garage"},
    Data = {currentMenu = 'Menu :'},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

        ESX.TriggerServerCallback('Tikoz:GetVehGarage', function(garageowner, iden) 

            if btn.name == "Garage" then
                menugarage.Menu["Garage :"].b = {}
                for i=1, #garageowner, 1 do
                    if iden == garageowner[i].owner then
                        if garageowner[i].stored == 1 then
                            table.insert(menugarage.Menu["Garage :"].b, { name = garageowner[i].label, ask = "~b~"..garageowner[i].plate, askX = true})
                        end
                    end
                end
                OpenMenu("Garage :")
            end

            for i=1, #garageowner, 1 do
                if btn.name == garageowner[i].label then
                    veh = garageowner[i].vehicle
                    pi = garageowner[i].name
                    plate = garageowner[i].plate
                    body = json.decode(garageowner[i].vehicle)
                    OpenMenu("Que voulez-vous faire ?")
                end
            end

            if btn.name == "Sortir le véhicule" then 
                
                CloseMenu()
                etat = "sort"
                local po = GetHashKey(pi)
                RequestModel(po)
                while not HasModelLoaded(po) do Wait(0) end
                pipo = CreateVehicle(po, spawnVehTikoz, true, false)
                TaskWarpPedIntoVehicle(PlayerPedId(), pipo, -1)
                ESX.Game.SetVehicleProperties(pipo, body)
                SetVehRadioStation(pipo, "OFF")
                TriggerServerEvent('Tikoz:GarageSortVeh', plate, etat)
            elseif btn.name == "Rename le véhicule" then
                local newName = Keyboardput("Quel est le nouveau nom du véhicule ? ", "", 29)
                TriggerServerEvent('Tikoz:GarageNewName', newName, plate)
                OpenMenu("Menu :")
            end

            if btn.name == "Véhicule en fourrière" then
                menugarage.Menu["Fourrière :"].b = {}
                for i=1, #garageowner, 1 do
                    if iden == garageowner[i].owner then
                        if garageowner[i].stored == 2 then
                            table.insert(menugarage.Menu["Fourrière :"].b, { name = "~s~"..garageowner[i].label, ask = "~b~"..garageowner[i].plate, askX = true})
                        end
                    end
                end
                OpenMenu("Fourrière :")
            end

        end, args)

        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Garage", ask = ">", askX = true},
                {name = "Véhicule en fourrière", ask = ">", askX = true},
            }
        },
        ["Garage :"] = {
            b = {
            }
        },
        ["Que voulez-vous faire ?"] = {
            b = {
                {name = "Sortir le véhicule", ask = "", askX = true},
                {name = "Rename le véhicule", ask = "", askX = true},
            }
        },
        ["Fourrière :"] = {
            b = {
            }
        },
    }
}

CreateThread(function()
    while true do
        if posgarage() then
            if IsControlJustPressed(1, 51) then
                CreateMenu(menugarage)
            end
        else
            Wait(1000)
        end
        Wait(0)
    end
end)

function posgarage()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)

	for _, v in pairs(ListeGarage) do
		local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, pos['x'], pos['y'], pos['z'], true)

		if distance <= 2 then
            spawnVehTikoz = v.spawn
            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, v.x, v.y, v.z, nil, nil, nil, -90, nil, nil, 0.8, 0.8, 0.8, 0, 251, 255, 200, false, true, 2, false, false, false, false)
			return true
        end
	end
end

CreateThread(function()
    while true do 
        if posrentre() then
            if IsControlJustPressed(1, 51) then
                ped = PlayerPedId()
                veh = GetVehiclePedIsIn(ped, false)
                plate = GetVehicleNumberPlateText(veh)

                ESX.TriggerServerCallback("Tikoz:GarageDespawnVeh", function(valid)
                    if valid then 
                        etat = "rentre"
                        pros = ESX.Game.GetVehicleProperties(veh)
                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId(), false))
                        TriggerServerEvent('Tikoz:GarageSortVeh', plate, etat, pros)
                        ESX.ShowNotification("Vous avez ranger votre ~b~véhicule")
                    else
                        ESX.ShowNotification("ce véhicule ne vous ~r~appartient pas")
                    end
                end, plate)
            end
        else
            Wait(1000)
        end
        Wait(0)
    end
end)

function posrentre()

    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    if IsPedSittingInAnyVehicle(ped) then 
        for k, v in pairs(ListeRentre) do 
            local dist = GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true)
            if dist <= 5 then

                DrawMarker(36, v.x, v.y, v.z+1, nil, nil, nil, 0, nil, nil, 2.8, 2.8, 2.8, 255, 0, 0, 200, false, true, 2, false, false, false, false)
                ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour rentrer ton ~b~véhicule")
                return true
            end
        end
    end
end


CreateThread(function()
    for i=1, #ListeGarage, 1 do 
        local blip = AddBlipForCoord(ListeGarage[i].x, ListeGarage[i].y)
        SetBlipSprite (blip, 50)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipColour (blip, 42)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage publique")
        EndTextCommandSetBlipName(blip)
    end
end)

menufourriere = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Fourrière"},
    Data = {currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            ESX.TriggerServerCallback('Tikoz:GetVehGarage', function(garageowner, iden) 

                if btn.name == "Fourrière" then
                    menufourriere.Menu["Fourrière"].b = {}
                    for i=1, #garageowner, 1 do
                        if iden == garageowner[i].owner then
                            if garageowner[i].stored == 2 then
                                table.insert(menufourriere.Menu["Fourrière"].b, { name = garageowner[i].label, ask = "~b~"..garageowner[i].plate, askX = true})
                            end
                        end
                    end
                    OpenMenu("Fourrière")
                end
    
                for i=1, #garageowner, 1 do
                    if btn.name == garageowner[i].label then
                        if iden == garageowner[i].owner then
                            veh = garageowner[i].vehicle
                            pi = garageowner[i].name
                            TriggerServerEvent("Tikoz:FourriereSortVehPayant", veh, pi)
                        end
                    end
                end
            end, args)
            
        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Fourrière", ask = ">", askX = true},
            }
        },
        ["Fourrière"] = {
            b = {
            }
        },
    }
}

RegisterNetEvent("Tikoz:FourriereSortVehPayant")
AddEventHandler("Tikoz:FourriereSortVehPayant", function(veh, pi)
    local ped = PlayerPedId()
    local po = GetHashKey(pi)
    RequestModel(po)
    while not HasModelLoaded(po) do Wait(0) end
    pipo = CreateVehicle(po, FourrierespawnVehTikoz, true, false)
    ESX.Game.SetVehicleProperties(pipo, json.decode(veh))
    TaskWarpPedIntoVehicle(ped, pipo, -1)
    SetVehRadioStation(pipo, "OFF")
    ESX.ShowNotification("Vous avez payé : ~g~"..Config.PrixFourriere.."$")
    CloseMenu()
end)


CreateThread(function()
    while true do
        Wait(0)
        if posfourriere() then
            if IsControlJustPressed(1, 51) then
                CreateMenu(menufourriere)
            end
        else
            Wait(1000)
        end
    end
end)

function posfourriere()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)

	for _, v in pairs(PosFourriere) do
		local distance = GetDistanceBetweenCoords(v.x, v.y, v.z, pos['x'], pos['y'], pos['z'], true)

		if distance <= 2 then
            FourrierespawnVehTikoz = v.Spawn
            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu\n\n~s~Prix pour sortir un véhicule : ~g~"..Config.PrixFourriere.."$")
            DrawMarker(6, v.x, v.y, v.z, nil, nil, nil, -90, nil, nil, 0.8, 0.8, 0.8, 0, 251, 255, 200, false, true, 2, false, false, false, false)
			return true
        end
	end
end

CreateThread(function()
    for i=1, #PosFourriere, 1 do 
        local blip = AddBlipForCoord(PosFourriere[i].x, PosFourriere[i].y)
        SetBlipSprite (blip, 67)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipColour (blip, 44)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Fourrière")
        EndTextCommandSetBlipName(blip)
    end
end)