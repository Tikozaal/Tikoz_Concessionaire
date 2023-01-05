ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

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

menucatalogue = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Catalogue"},
    Data = { currentMenu = "Menu"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Compacts" then
                OpenMenu('Compacts')
            elseif btn.name == "Coupés" then
                OpenMenu('Coupés')
            elseif btn.name == "Sedans" then
                OpenMenu('Sedans')
            elseif btn.name == "Sports" then
                OpenMenu('Sports')
            elseif btn.name == "Sports Classics" then
                OpenMenu('Sports Classics')
            elseif btn.name == "Muscle" then
                OpenMenu('Muscle')
            elseif btn.name == "Off Road" then
                OpenMenu('Off Road')
            elseif btn.name == "SUV" then
                OpenMenu('SUV')
            elseif btn.name == "Vans" then
                OpenMenu('Vans')
            elseif btn.name == "Moto" then
                OpenMenu('Moto')
            end

            ESX.TriggerServerCallback("Tikoz:Concessvehicule", function(vehicules) 
                
                if btn.name == "Compacts" then
                    menucatalogue.Menu["Compacts"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "compacts" then
                            prixcata = vehicules[i].price*1.30
                            table.insert(menucatalogue.Menu["Compacts"].b, { name = vehicules[i].name, ask = "~g~"..prixcata.."$", askX = true})
                        end
                    end
                    OpenMenu('Compacts')
                end
                
                if btn.name == "Coupés" then
                    menucatalogue.Menu["Coupés"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "coupes" then
                            prixcata = vehicules[i].price*1.30
                            table.insert(menucatalogue.Menu["Coupés"].b, { name = vehicules[i].name, ask = "~g~"..prixcata.."$", askX = true})
                        end
                    end
                    OpenMenu('Coupés')
                end
            
                if btn.name == "Sedans" then
                    menucatalogue.Menu["Sedans"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "sedans" then
                            prixcata = vehicules[i].price*1.30
                            table.insert(menucatalogue.Menu["Sedans"].b, { name = vehicules[i].name, ask = "~g~"..prixcata.."$", askX = true})
                        end
                    end
                    OpenMenu('Sedans')
                end

                if btn.name == "Sports" then
                    menucatalogue.Menu["Sports"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "sports" then
                            prixcata = vehicules[i].price*1.30
                            table.insert(menucatalogue.Menu["Sports"].b, { name = vehicules[i].name, ask = "~g~"..prixcata.."$", askX = true})
                        end
                    end
                    OpenMenu('Sports')
                end
            
                if btn.name == "Sports Classics" then
                    menucatalogue.Menu["Sports Classics"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "sportsclassics" then
                            prixcata = vehicules[i].price*1.30
                            table.insert(menucatalogue.Menu["Sports Classics"].b, { name = vehicules[i].name, ask = "~g~"..prixcata.."$", askX = true})
                        end
                    end
                    OpenMenu('Sports Classics')
                end
            
                if btn.name == "Super" then
                    menucatalogue.Menu["Super"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "super" then
                            prixcata = vehicules[i].price*1.30
                            table.insert(menucatalogue.Menu["Super"].b, { name = vehicules[i].name, ask = "~g~"..prixcata.."$", askX = true})
                        end
                    end
                    OpenMenu('Super')
                end
            
                if btn.name == "Muscle" then
                    menucatalogue.Menu["Muscle"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "muscle" then
                            prixcata = vehicules[i].price*1.30
                            table.insert(menucatalogue.Menu["Muscle"].b, { name = vehicules[i].name, ask = "~g~"..prixcata.."$", askX = true})
                        end
                    end
                    OpenMenu('Muscle')
                end
            
                if btn.name == "Off Road" then
                    menucatalogue.Menu["Off Road"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "offroad" then
                            prixcata = vehicules[i].price*1.30
                            table.insert(menucatalogue.Menu["Off Road"].b, { name = vehicules[i].name, ask = "~g~"..prixcata.."$", askX = true})
                        end
                    end
                    OpenMenu('Off Road')
                end
            
                if btn.name == "SUV" then
                    menucatalogue.Menu["SUV"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "suvs" then
                            prixcata = vehicules[i].price*1.30
                            table.insert(menucatalogue.Menu["SUV"].b, { name = vehicules[i].name, ask = "~g~"..prixcata.."$", askX = true})
                        end
                    end
                    OpenMenu('SUV')
                end
            
                if btn.name == "Vans" then
                    menucatalogue.Menu["Vans"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "vans" then
                            prixcata = vehicules[i].price*1.30
                            table.insert(menucatalogue.Menu["Vans"].b, { name = vehicules[i].name, ask = "~g~"..prixcata.."$", askX = true})
                        end
                    end
                    OpenMenu('Vans')
                end
            
                if btn.name == "Moto" then
                    menucatalogue.Menu["Moto"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "motorcycles" then
                            prixcata = vehicules[i].price*1.30
                            table.insert(menucatalogue.Menu["Moto"].b, { name = vehicules[i].name, ask = "~g~"..prixcata.."$", askX = true})
                        end
                    end
                    OpenMenu('Moto')
                end

                for i=1, #vehicules, 1 do
                    if btn.name == vehicules[i].name then
                        local pa = vehicules[i].name
                        local pi = vehicules[i].label
                        local po = GetHashKey(pi)
                        RequestModel(po)
                        while not HasModelLoaded(po) do Citizen.Wait(0) end
                        local pipo = CreateVehicle(po, Config.Pos.SortiVehicule, true, false)
                        TaskWarpPedIntoVehicle(PlayerPedId(), pipo, -1)
                        SetVehRadioStation(pipo, 'OFF')
                        CloseMenu()
                        ESX.ShowAdvancedNotification('Concessionnaire', '~b~Secrétaire', "Vous avez ~b~1 minute~s~ pour essayer la ~b~"..pa, 'CHAR_MOLLY', 8)

                        Citizen.Wait(60000)

                        ESX.ShowAdvancedNotification('Concessionnaire', '~b~Secrétaire', "La location est terminée", 'CHAR_MOLLY', 8)

                        DeleteVehicle(pipo)
                        SetEntityCoords(PlayerPedId(), Config.Pos.Catalogue)

                    end
                end

            end, args)

        end,
},
    Menu = {
        ["Menu"] = {
            b = {
                {name = "Compacts", ask = ">", askX = true},
                {name = "Coupés", ask = ">", askX = true},
                {name = "Sedans", ask = ">", askX = true},
                {name = "Sports", ask = ">", askX = true},
                {name = "Sports Classics", ask = ">", askX = true},
                {name = "Super", ask = ">", askX = true},
                {name = "Muscle", ask = ">", askX = true},
                {name = "Off Road", ask = ">", askX = true},
                {name = "SUV", ask = ">", askX = true},
                {name = "Vans", ask = ">", askX = true},
                {name = "Moto", ask = ">", askX = true},
            }
        },
        ["Imports"] = {
            b = {
            }
        },
        ["Compacts"] = {
            b = {
            }
        },
        ["Coupés"] = {
            b = {
            }
        },
        ["Sedans"] = {
            b = {
            }
        },
        ["Sports"] = {
            b = {
            }
        },
        ["Sports Classics"] = {
            b = {
            }
        },
        ["Super"] = {
            b = {
            }
        },
        ["Muscle"] = {
            b = {
            }
        },
        ["Off Road"] = {
            b = {
            }
        },
        ["SUV"] = {
            b = {
            }
        },
        ["Vans"] = {
            b = {
            }
        },
        ["Moto"] = {
            b = {
            }
        },
    }
}

Citizen.CreateThread(function()

    while true do 

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local menu = Config.Pos.Catalogue
        local dist = #(pos - menu)

        if dist <= 2 then

            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~catalogue")
            DrawMarker(6, menu, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1, 51) then
                CreateMenu(menucatalogue)
            end

        else 
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)