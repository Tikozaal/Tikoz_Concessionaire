ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Tikozaal = {}
local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
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

    ESX.PlayerData = ESX.GetPlayerData()
    WeaponData = ESX.GetWeaponList()

    for i = 1, #WeaponData, 1 do
        if WeaponData[i].name == 'WEAPON_UNARMED' then
            WeaponData[i] = nil
        else
            WeaponData[i].hash = GetHashKey(WeaponData[i].name)
        end
    end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

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

menucoffre = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251 ,255}, Title = "Coffre"},
    Data = { currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            ESX.TriggerServerCallback("Tikoz:Inventaireconcess", function(inventory) 
                if btn.name == "Déposé" then
                    menucoffre.Menu["Déposé"].b = {}
                    for i=1, #inventory.items, 1 do 
                        local item = inventory.items[i]
                        if item.count > 0 then
                            table.insert(menucoffre.Menu["Déposé"].b, { name = "~s~"..item.label, ask = "~b~x"..item.count, askX = true})
                        end
                    end
                    OpenMenu("Déposé")
                end

                for i=1, #inventory.items, 1 do 
                    local item = inventory.items[i]
                    if btn.name == "~s~"..item.label then
                        count = Keyboardput("Combien voulez vous déposé ? ", "", 15)
                        TriggerServerEvent('Tikoz:CoffreDeposeconcess', item.name, tonumber(count))
                        OpenMenu("Menu :")
                    end
                end
            end)

            ESX.TriggerServerCallback("Tikoz:CoffreSocietyconcess", function(items)
                
               itemstock = {} 
               itemstock = items

               if btn.name == "Retiré" then
                    menucoffre.Menu["Retiré"].b = {}

                    for i=1, #itemstock, 1 do

                        if itemstock[i].count > 0 then
                            table.insert(menucoffre.Menu["Retiré"].b, { name = itemstock[i].label, ask = "~b~x"..itemstock[i].count, askX = true})
                        end
                    end
                    OpenMenu("Retiré")
                end

                for i=1, #itemstock, 1 do 
                
                    if btn.name == itemstock[i].label then
                    
                        itemLabel = itemstock[i].label
                        count = Keyboardput("Combien voulez vous déposé ? ", "", 15)
                        TriggerServerEvent('Tikoz:RetireCoffreconcess', itemstock[i].name, tonumber(count), itemLabel)
                        OpenMenu("Menu :")
                    end

                end

            end)

            if btn.name == "Déposé arme" then
                ESX.PlayerData = ESX.GetPlayerData()
                menucoffre.Menu["Déposé arme"].b = {}
                    if #WeaponData > 0 then
                        for i = 1, #WeaponData, 1 do
                            if (HasPedGotWeapon(PlayerPedId(), WeaponData[i].hash, false)) then
                                local currentAmmo = GetAmmoInPedWeapon(PlayerPedId(), WeaponData[i].hash)
                                table.insert(menucoffre.Menu["Déposé arme"].b, { name = WeaponData[i].label, ask = "~b~x"..currentAmmo, askX = true})
                            end
                        end
                    end
                OpenMenu('Déposé arme')
            end

           for i=1, #WeaponData, 1 do 
                if btn.name == WeaponData[i].label then
                    local name = WeaponData[i].name
                    local label = WeaponData[i].label
                    local balle = GetAmmoInPedWeapon(PlayerPedId(), WeaponData[i].hash)
                    local job = "concess" 
                    TriggerServerEvent('Tikoz:concessDeposeWeapon', name, label, balle, job)
                    OpenMenu('Menu :')
                end
            end

            ESX.TriggerServerCallback("Tikoz:concessCoffrerecupweapon", function(coffreweapon) 
                
                if btn.name == "Retiré arme" then
                    menucoffre.Menu["Retiré arme"].b = {}
                    for i=1, #coffreweapon, 1 do 
                        if coffreweapon[i].job == "concess" then
                            table.insert(menucoffre.Menu["Retiré arme"].b, { name = "~s~"..coffreweapon[i].label, ask = "~b~x"..coffreweapon[i].balle, askX = true})
                        end
                    end
                    OpenMenu("Retiré arme")
                end

                for i=1, #coffreweapon, 1 do
                    if btn.name == "~s~"..coffreweapon[i].label then
                        local id = coffreweapon[i].id
                        local name = coffreweapon[i].name
                        local label = coffreweapon[i].label
                        local balle = coffreweapon[i].balle
                        local job = coffreweapon[i].job
                        local gang = coffreweapon[i].gang
                        TriggerServerEvent('Tikoz:concessCoffreRetirerWeapon', id, name, label, balle, job, gang)
                        OpenMenu("Menu :")
                    end
                end

            end)

        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Déposé", ask = ">", askX = true},
                {name = "Retiré", ask = ">", askX = true},
                {name = "", ask = "", askX = true},
                {name = "Déposé arme", ask = ">", askX = true},
                {name = "Retiré arme", ask = ">", askX = true},
            }
        },
        ["Déposé"] = {
            b = {
            }
        },
        ["Retiré"] = {
            b = {
            }
        },
        ["Déposé arme"] = {
            b = {
            }
        },
        ["Retiré arme"] = {
            b = {
            }
        },
    }
}

Citizen.CreateThread(function()

    while true do 
       
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local menu = Config.Pos.Coffre 
        local dist = #(pos - menu)

        if dist <= 2 and ESX.PlayerData.job.name == "concess" then

            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, menu, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1, 51) then
                CreateMenu(menucoffre)
            end

        else 
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)