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
end)

function RefreshMoney()
    Citizen.CreateThread(function()
            ESX.Math.GroupDigits(ESX.PlayerData.money)
            ESX.Math.GroupDigits(ESX.PlayerData.accounts[1].money)
            ESX.Math.GroupDigits(ESX.PlayerData.accounts[2].money)
    end)
end

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


function factureconcess()
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
              table.insert(menufacture.Menu["Facture ~b~envoyé"].b, {name = "~b~"..GetPlayerName(closestPlayer), ask = "~g~"..amount.."$", askX = true})
  
          end)
        end
    end
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

menuf5concess = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Concessionaire"},
    Data = { currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Annonce" then
                OpenMenu("Annonce")
            elseif btn.name == "~b~Concessionaire ~s~ouvert" then
                etat = "ouvert"
                TriggerServerEvent('Tikoz:ConcessAnnonce', etat)
            elseif btn.name == "~b~Concessionaire ~s~fermé" then
                etat = "fermer"
                TriggerServerEvent('Tikoz:ConcessAnnonce', etat)
            elseif btn.name == "~b~Concessionnaire ~s~Personnaliser" then
                etat = "perso"
                msgpersoconcess = Keyboardput("Message", "", 145)
                TriggerServerEvent('Tikoz:ConcessAnnonce', etat, msgpersoconcess)
            end
            
            if btn.name == "Facture" then
                factureconcess()
            end

            if ESX.PlayerData.job.grade_name == "boss" and ESX.PlayerData.job.name == "concess" then 
                if btn.name == "Gestion d'entreprise" then
                    menuf5concess.Menu["Gestion"].b = {}
                    table.insert(menuf5concess.Menu["Gestion"].b, { name = "Recruter", ask = "", askX = true})   
                    table.insert(menuf5concess.Menu["Gestion"].b, { name = "Promouvoir", ask = "", askX = true})
                    table.insert(menuf5concess.Menu["Gestion"].b, { name = "Destituer" , ask = "", askX = true})
                    table.insert(menuf5concess.Menu["Gestion"].b, { name = "Virer", ask = "", askX = true})
                    OpenMenu('Gestion')
                end
            end
            if btn.name == "Recruter" then 
                if ESX.PlayerData.job.grade_name == 'boss'  then
                    Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
                    if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
                        ESX.ShowNotification('Aucun joueur à ~b~proximité')
                    else
                        TriggerServerEvent('Tikoz:ConcessRecruter', GetPlayerServerId(Tikozaal.closestPlayer), ESX.PlayerData.job.name, 0)
                    end
                else
                    ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                end
            elseif btn.name == "Promouvoir" then
                if ESX.PlayerData.job.grade_name == 'boss' then
                    Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
                    if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
                        ESX.ShowNotification('Aucun joueur à ~b~proximité')
                    else
                        TriggerServerEvent('Tikoz:PromotionConcess', GetPlayerServerId(Tikozaal.closestPlayer))
                    end
                else
                    ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                end
            elseif btn.name == "Virer" then 
                if ESX.PlayerData.job.grade_name == 'boss' then
                    Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
                    if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
                        ESX.ShowNotification('Aucun joueur à ~b~proximité')
                    else
                        TriggerServerEvent('Tikoz:ConcessVirer', GetPlayerServerId(Tikozaal.closestPlayer))
                    end
                else
                    ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                end
            elseif btn.name == "Destituer" then 
                if ESX.PlayerData.job.grade_name == 'boss' then
                    Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
                    if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
                        ESX.ShowNotification('Aucun joueur à ~b~proximité')
                    else
                        TriggerServerEvent('Tikoz:ConcessRetrograder', GetPlayerServerId(Tikozaal.closestPlayer))
                    end
                else
                    ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                end
            end

        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Annonce", ask = ">", askX = true},
                {name = "Facture", ask = ">", askX = true},
                {name = "Gestion d'entreprise", ask = ">", askX = true},
            }
        },
        ["Annonce"] = {
            b = {
                {name = "~b~Concessionaire ~s~ouvert", ask = "", askX = true},
                {name = "~b~Concessionaire ~s~fermé", ask = "", askX = true},
                {name = "~b~Concessionnaire ~s~Personnaliser", ask = "", askX = true},
            }
        },
        ["Gestion"] = {
            b = {
            }
        },
    }
}

keyRegister("concessionaire", "Menu F6", "F6", function()
    if ESX.PlayerData.job.name == "concess" then
        CreateMenu(menuf5concess)
    end
end)

