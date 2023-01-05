falseESX = nil

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

function factureconcessvente()
    local amount = Keyboardput("Entré le montant", "", 15)
    
    if not amount then
      ESX.ShowNotification('~r~Montant invalide')
    else
  
      local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  
      if closestPlayer == -1 or closestDistance > 3.0 then
          ESX.ShowNotification('Pas de joueurs à ~b~proximité')
      else
          local playerPed = PlayerPedId()
  
          Citizen.CreateThread(function()
           
              ClearPedTasks(playerPed)
              TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_concess', "~b~Concessionnaire", amount)
              ESX.ShowNotification("Vous avez bien envoyer la ~b~facture")  
          end)
        end
    end
end
  
menuconcess = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251 ,255}, Title = "Concessionnaire"},
    Data = { currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Acheté un véhicule" then
                OpenMenu("Catalogue :")
            end
            
            if btn.name == "Rangé le véhicule" then
                DeleteVehicle(creacar)
            end
            if btn.name == "Imports" then
                OpenMenu('Imports')
            elseif btn.name == "Compacts" then
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
                    menuconcess.Menu["Compacts"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "compacts" then
                            table.insert(menuconcess.Menu["Compacts"].b, { name = vehicules[i].name, ask = "~g~"..vehicules[i].price.."$", askX = true})
                        end
                    end
                    OpenMenu('Compacts')
                end
                
                if btn.name == "Coupés" then
                    menuconcess.Menu["Coupés"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "coupes" then
                            table.insert(menuconcess.Menu["Coupés"].b, { name = vehicules[i].name, ask = "~g~"..vehicules[i].price.."$", askX = true})
                        end
                    end
                    OpenMenu('Coupés')
                end
            
                if btn.name == "Sedans" then
                    menuconcess.Menu["Sedans"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "sedans" then
                            table.insert(menuconcess.Menu["Sedans"].b, { name = vehicules[i].name, ask = "~g~"..vehicules[i].price.."$", askX = true})
                        end
                    end
                    OpenMenu('Sedans')
                end

                if btn.name == "Sports" then
                    menuconcess.Menu["Sports"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "sports" then
                            table.insert(menuconcess.Menu["Sports"].b, { name = vehicules[i].name, ask = "~g~"..vehicules[i].price.."$", askX = true})
                        end
                    end
                    OpenMenu('Sports')
                end
            
                if btn.name == "Sports Classics" then
                    menuconcess.Menu["Sports Classics"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "sportsclassics" then
                            table.insert(menuconcess.Menu["Sports Classics"].b, { name = vehicules[i].name, ask = "~g~"..vehicules[i].price.."$", askX = true})
                        end
                    end
                    OpenMenu('Sports Classics')
                end
            
                if btn.name == "Super" then
                    menuconcess.Menu["Super"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "super" then
                            table.insert(menuconcess.Menu["Super"].b, { name = vehicules[i].name, ask = "~g~"..vehicules[i].price.."$", askX = true})
                        end
                    end
                    OpenMenu('Super')
                end
            
                if btn.name == "Muscle" then
                    menuconcess.Menu["Muscle"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "muscle" then
                            table.insert(menuconcess.Menu["Muscle"].b, { name = vehicules[i].name, ask = "~g~"..vehicules[i].price.."$", askX = true})
                        end
                    end
                    OpenMenu('Muscle')
                end
            
                if btn.name == "Off Road" then
                    menuconcess.Menu["Off Road"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "offroad" then
                            table.insert(menuconcess.Menu["Off Road"].b, { name = vehicules[i].name, ask = "~g~"..vehicules[i].price.."$", askX = true})
                        end
                    end
                    OpenMenu('Off Road')
                end
            
                if btn.name == "SUV" then
                    menuconcess.Menu["SUV"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "suvs" then
                            table.insert(menuconcess.Menu["SUV"].b, { name = vehicules[i].name, ask = "~g~"..vehicules[i].price.."$", askX = true})
                        end
                    end
                    OpenMenu('SUV')
                end
            
                if btn.name == "Vans" then
                    menuconcess.Menu["Vans"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "vans" then
                            table.insert(menuconcess.Menu["Vans"].b, { name = vehicules[i].name, ask = "~g~"..vehicules[i].price.."$", askX = true})
                        end
                    end
                    OpenMenu('Vans')
                end
            
                if btn.name == "Moto" then
                    menuconcess.Menu["Moto"].b = {}
                    for i=1, #vehicules, 1 do
                        if vehicules[i].category == "motorcycles" then
                            table.insert(menuconcess.Menu["Moto"].b, { name = vehicules[i].name, ask = "~g~"..vehicules[i].price.."$", askX = true})
                        end
                    end
                    OpenMenu('Moto')
                end
              
                for i=1, #vehicules, 1 do 
                    if btn.name == vehicules[i].name then
                        local prix = vehicules[i].price
                        local label = vehicules[i].label
                        local name = vehicules[i].name
                        local po = GetHashKey(label) 
                        RequestModel(po)
                        while not HasModelLoaded(po) do Wait(0) end

                        local pipo = CreateVehicle(po, -35.35, -1100.68, 25.32, 234.32, false, false)

                        local body = ESX.Game.GetVehicleProperties(pipo)
                        local plate = GetVehicleNumberPlateText(pipo)
                        TriggerServerEvent('Tikoz:ConcessionnaireBuyVeh', name, label, body, prix, plate)
                        DeleteVehicle(pipo)
                    end
                end

            end, args)
            
            ESX.TriggerServerCallback("Tikoz:ConcessSortirVehicule", function(concessrendvehicule) 

                if btn.name == "Garage entreprise" then
                    menuconcess.Menu["Stock"].b = {}
                    for i=1, #concessrendvehicule, 1 do 
                        table.insert(menuconcess.Menu["Stock"].b, { name = "~s~"..concessrendvehicule[i].name, ask = "~b~"..concessrendvehicule[i].plate.."                     ~g~"..concessrendvehicule[i].prix.."$", askX = true})
                    end
                    OpenMenu('Stock')
                end
                
                for i=1, #concessrendvehicule, 1 do
                    if btn.name == "~s~"..concessrendvehicule[i].name then
                        idaply = concessrendvehicule[i].id
                        nameaply = concessrendvehicule[i].name
                        labelaply = concessrendvehicule[i].label 
                        bodyaply = json.decode(concessrendvehicule[i].body) 
                        prixaply = concessrendvehicule[i].prix 
                        plateaply = concessrendvehicule[i].plate 
                        OpenMenu("Véhicule")
                    end
                

                    if btn.name == "Sortir le ~b~véhicule" then
                        local carh = GetHashKey(labelaply)
                        RequestModel(carh)
                        while not HasModelLoaded(carh) do Citizen.Wait(0) end
                        local tikozcar = CreateVehicle(carh, -36.45, -1101.92, 26.42, 331.59, true, false)
                        ESX.Game.SetVehicleProperties(tikozcar, bodyaply)
                        TriggerServerEvent('Tikoz:RetireTchop', idaply)
                        OpenMenu('Menu :')
                        return
                    end
          
                    if btn.name == "Donner les ~b~clés" then
                        Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
                        TriggerServerEvent('Tikoz:ConcessionnairSetVeh', nameaply, labelaply, bodyaply, prixaply, plateaply, GetPlayerServerId(Tikozaal.closestPlayer))
                        return
                    elseif btn.name == "Faire une ~b~facture" then
                        factureconcessvente()
                    end
                end
                
            end, args)

 

        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Acheté un véhicule", ask = ">", askX = true},
                {name = "Garage entreprise", ask = ">", askX = true},
            }
        },
        ["Stock"] = {
            b = {
            }
        },
        ["Véhicule"] = {
            b = {
                {name = "Sortir le ~b~véhicule", ask = "", askX = true},
                {name = "Faire une ~b~facture", ask = "", askX = true},
                {name = "Donner les ~b~clés", ask = "", askX = true},
            }
        },
        ["Catalogue :"] = {
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

CreateThread(function()

    while true do 
       
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local menu = Config.Pos.Menu
        local dist = #(pos - menu)

        if dist <= 2 and ESX.PlayerData.job.name == "concess" then

            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, menu, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1, 51) then
                CreateMenu(menuconcess)
            end
        else 
            Wait(1000)
        end
        Wait(0)
    end
end)



Citizen.CreateThread(function()
    
    if Config.Pos.VehiculeExpo == true then
        local car = Config.Car.Voiture
        local carh = GetHashKey(car)
        RequestModel(carh)
        while not HasModelLoaded(carh) do Citizen.Wait(0) end
        tikoz = CreateVehicle(carh, Config.Car.Pos1, false, false)
        SetVehicleDoorsLocked(tikoz, 2)

        local car = Config.Car.Voiture2
        carh = GetHashKey(car)
        RequestModel(carh)
        while not HasModelLoaded(carh) do Citizen.Wait(0) end
        tikoz2 = CreateVehicle(carh, Config.Car.Pos2, false, false)
        SetVehicleDoorsLocked(tikoz2, 2)

        local car = Config.Car.Voiture3
        local carh = GetHashKey(car)
        RequestModel(carh)
        while not HasModelLoaded(carh) do Citizen.Wait(0) end
        tikoz3 = CreateVehicle(carh, Config.Car.Pos3, false, false)
        SetVehicleDoorsLocked(tikoz3, 2)
        Holograms()
    else 

    end
    
end)


function buyvoiture()
    local car = Config.Car.Voiture
    local prix = Config.Car.prix
    local label = Config.Car.Label
    local vehicleProps = ESX.Game.GetVehicleProperties(tikoz)
    local newPlate = GetVehicleNumberPlateText(tikoz)
    TriggerServerEvent('Tikoz:setVehicleOwned', vehicleProps, newPlate, prix, car, label)
end

function buyvoiture2()

    local car = Config.Car.Voiture2
    local prix = Config.Car.prix2
    local label = Config.Car.Label2
    local vehicleProps = ESX.Game.GetVehicleProperties(tikoz2)
    local newPlate = GetVehicleNumberPlateText(tikoz2)
    TriggerServerEvent('Tikoz:setVehicleOwned', vehicleProps, newPlate, prix, car, label)
end

function buyvoiture3()

    local car = Config.Car.Voiture3
    local prix = Config.Car.prix3
    local label = Config.Car.Label3
    local vehicleProps = ESX.Game.GetVehicleProperties(tikoz3)
    local newPlate = GetVehicleNumberPlateText(tikoz3)
    TriggerServerEvent('Tikoz:setVehicleOwned', vehicleProps, newPlate, prix, car, label)

end

RegisterNetEvent('Tikoz:SortCarShopVitrine')
AddEventHandler('Tikoz:SortCarShopVitrine', function(plate, car)
    local ped = PlayerPedId()
    local carh = GetHashKey(car)
    RequestModel(carh)
    while not HasModelLoaded(carh) do Citizen.Wait(0) end
    local tikoz = CreateVehicle(carh, Config.Pos.SortiVehicule, true, false)
    SetVehicleNumberPlateText(tikoz, plate)
    TaskWarpPedIntoVehicle(ped, tikoz, -1)
    SetVehRadioStation(tikoz, "OFF")
end)

CreateThread(function()
    if Config.Blip.UseBlip == true then
        local blip = AddBlipForCoord(Config.Blip.Pos)
        SetBlipSprite (blip, Config.Blip.Id)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, Config.Blip.Taille)
        SetBlipColour (blip, Config.Blip.Couleur)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Blip.Nom)
        EndTextCommandSetBlipName(blip)
    end
end)


function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)	
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function TextBuy(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
    local scale = (1/dist)*10
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov   
    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(250, 250, 250, 255)	
    SetTextDropshadow(1, 1, 1, 1, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end