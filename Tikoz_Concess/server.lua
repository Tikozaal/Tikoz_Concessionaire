ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'concessionnaire', 'concessionnaire', 'society_concess', 'society_concess', 'society_concess', {type = 'public'})

------------------------ ANNONCE ---------------------

RegisterServerEvent('Tikoz:ConcessAnnonce')
AddEventHandler('Tikoz:ConcessAnnonce', function(etat, msgpersoconcess)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if etat == "ouvert" then
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Concessionnaire", '~b~Annonce', 'Nous sommes ~g~ouvert~s~ !', 'CHAR_CHAT_CALL', 8)
		elseif etat == "fermer" then
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Concessionnaire", '~b~Annonce', 'Nous sommes ~r~fermé~s~ !', 'CHAR_CHAT_CALL', 8)
		elseif etat == "perso" then
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Concessionnaire", '~b~Annonce', msgpersoconcess, 'CHAR_CHAT_CALL', 8)
		end
	end
end)

local Vehicles = {}

ESX.RegisterServerCallback('Tikoz:Concessvehicule', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local vehicules = {}

    MySQL.Async.fetchAll('SELECT * FROM vehicles', {

    }, function(result)

        for i=1, #result, 1 do

            table.insert(vehicules, {
                name = result[i].name,
                label = result[i].label,
                price = result[i].price,
                category = result[i].category,
            })

        end

        cb(vehicules)
    
    end)

end)

--------------------------- Action Patron ------------------

RegisterServerEvent('Tikoz:ConcessRecruter')
AddEventHandler('Tikoz:ConcessRecruter', function(target, job, grade)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	targetXPlayer.setJob(job, grade)
	TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~recruté " .. targetXPlayer.name .. "~w~.")
	TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~embauché par " .. sourceXPlayer.name .. "~w~.")
end)

RegisterServerEvent('Tikoz:PromotionConcess')
AddEventHandler('Tikoz:PromotionConcess', function(target)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == 3) then
		TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~b~promouvoir~w~ d'avantage.")
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			local grade = tonumber(targetXPlayer.job.grade) + 1
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~b~promu " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~b~promu~s~ par " .. sourceXPlayer.name .. "~w~.")
		end
	end
end)


RegisterServerEvent('Tikoz:ConcessRetrograder')
AddEventHandler('Tikoz:ConcessRetrograder', function(target)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == 0) then
		TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~r~rétrograder~w~ d'avantage.")
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			local grade = tonumber(targetXPlayer.job.grade) - 1
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~rétrogradé " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~r~rétrogradé par " .. sourceXPlayer.name .. "~w~.")
		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
		end
	end
end)

RegisterServerEvent('Tikoz:ConcessVirer')
AddEventHandler('Tikoz:ConcessVirer', function(target)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local job = "unemployed"
	local grade = "0"
	if (sourceXPlayer.job.name == targetXPlayer.job.name) then
		targetXPlayer.setJob(job, grade)
		TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré " .. targetXPlayer.name .. "~w~.")
		TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~viré par " .. sourceXPlayer.name .. "~w~.")
	else
		TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
	end
end)

----------------------- COFFRE ------------------------------

ESX.RegisterServerCallback('Tikoz:concessSalaire', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local salaireburgershot = {}

    MySQL.Async.fetchAll('SELECT * FROM job_grades', {

    }, function(result)

        for i=1, #result, 1 do

            table.insert(salaireburgershot, {
				id = result[i].id,
                job_name = result[i].job_name,
                label = result[i].label,
                salary = result[i].salary,
            })
        end
        cb(salaireburgershot)
    end)
end)

RegisterServerEvent("Tikoz:concessNouveauSalaire")
AddEventHandler("Tikoz:concessNouveauSalaire", function(id, label, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("UPDATE job_grades SET salary = "..amount.." WHERE id = "..id,
	{
		['@id'] = id,
		['@salary'] = amount
	}, function (rowsChanged)
	end)
end)


ESX.RegisterServerCallback('Tikoz:getSocietyMoney', function(source, cb, societyName)
	if societyName ~= nil then
	  local society = "society_concess"
	  TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
		cb(account.money)
	  end)
	else
	  cb(0)
	end
end)

ESX.RegisterServerCallback('Tikoz:ConcessArgentEntreprise', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local compteentreprise = {}


    MySQL.Async.fetchAll('SELECT * FROM addon_account_data WHERE account_name = "society_concess"', {

    }, function(result)

        for i=1, #result, 1 do
            table.insert(compteentreprise, {
                account_name = result[i].account_name,
                money = result[i].money,
            })
        end
        cb(compteentreprise)
    end)
end)

RegisterServerEvent("Tikoz:concessdepotentreprise")
AddEventHandler("Tikoz:concessdepotentreprise", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getAccount('bank').money
    
    TriggerEvent('esx_addonaccount:getSharedAccount', "society_concess", function (account)
        if xMoney >= total then
            account.addMoney(total)
            xPlayer.removeAccountMoney('bank', total)
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque Société', "~b~concess", "Vous avez déposé ~g~"..total.." $~s~ dans votre ~b~entreprise", 'CHAR_BANK_FLEECA', 9)
        else
            TriggerClientEvent('esx:showNotification', source, "<C>~r~Vous n'avez pas assez d'argent !")
        end
    end)   
end)

RegisterServerEvent("Tikoz:concessRetraitEntreprise")
AddEventHandler("Tikoz:concessRetraitEntreprise", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	local xMoney = xPlayer.getAccount("bank").money
	
	TriggerEvent('esx_addonaccount:getSharedAccount', "society_concess", function (account)
		if account.money >= total then
			account.removeMoney(total)
			xPlayer.addAccountMoney('bank', total)
			TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque Société', "~b~concess", "Vous avez retiré ~g~"..total.." $~s~ de votre ~b~entreprise", 'CHAR_BANK_FLEECA', 9)
		else
			TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque Société', "~b~concess", "Vous avez pas assez d'argent dans votre ~b~entreprise", 'CHAR_BANK_FLEECA', 9)
		end
	end)
end) 


ESX.RegisterServerCallback('Tikoz:concessCoffrerecupweapon', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local coffreweapon = {}

    MySQL.Async.fetchAll('SELECT * FROM tikoz_stockweapon', {

    }, function(result)

        for i=1, #result, 1 do
            table.insert(coffreweapon, {
                id = result[i].id,
				name = result[i].name,
				label = result[i].label,
                balle = result[i].balle,
                job = result[i].job,
				gang = result[i].gang,
            })
        end
        cb(coffreweapon)
    end)
end)

RegisterServerEvent("Tikoz:concessDeposeWeapon")
AddEventHandler("Tikoz:concessDeposeWeapon", function(name, label, balle, job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeWeapon(name, balle)

	MySQL.Async.execute("INSERT INTO tikoz_stockweapon (name, label, balle, job, gang) VALUES (@name, @label, @balle, @job, @gang)",
	{['@name'] = name, ['@label'] = label, ["@balle"] = balle, ["@job"] = job, ["@gang"] = "null"})

end)

RegisterServerEvent("Tikoz:concessCoffreRetirerWeapon")
AddEventHandler("Tikoz:concessCoffreRetirerWeapon", function(id, name, label, balle, job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.addWeapon(name, balle)

	MySQL.Async.execute('DELETE FROM tikoz_stockweapon WHERE id = '..id, {
        ["@id"] = id
    }, function()
    end)
end)

ESX.RegisterServerCallback('Tikoz:Inventaireconcess', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterServerEvent("Tikoz:CoffreDeposeconcess")
AddEventHandler("Tikoz:CoffreDeposeconcess", function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_concess', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, "Vous avez déposé ~y~x"..count.." ~b~"..inventoryItem.label)
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('Tikoz:CoffreSocietyconcess', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_concess', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('Tikoz:RetireCoffreconcess')
AddEventHandler('Tikoz:RetireCoffreconcess', function(itemName, count, itemLabel)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_concess', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, "Vous avez retiré ~y~x"..count.." ~b~"..itemLabel)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

----------------------------------- Tikoz -------------------------

RegisterServerEvent('Tikoz:setVehicleOwned')
AddEventHandler('Tikoz:setVehicleOwned', function (vehicleProps, plate, prix, car, label)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local bank = xPlayer.getAccount('bank').money
	local nameped = GetPlayerName(_source)
	
	if bank >= prix then
	
		xPlayer.removeAccountMoney('bank', prix)
		TriggerClientEvent('Tikoz:SortCarShopVitrine', _source, plate, car)
		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, nom, plate, name, label, vehicle, stored, reprog) VALUES (@owner, @nom, @plate, @name, @label, @vehicle, @stored, @reprog)',
		{
			['@owner']   = xPlayer.identifier,
			["@nom"]     = nameped,
			['@plate']   = plate,
			["@name"]    = car,
			["label"]    = label,
			['@vehicle'] = json.encode(vehicleProps),
            ["@stored"]  = 2,
			["@reprog"]  = 0,
		}, function (rowsChanged)
		end)
		TriggerClientEvent('esx:showAdvancedNotification', source, 'Concessionaire', "~g~Paiement accepté", "Vous avez acheté :~b~ "..label.."~s~\nPrix : ~g~"..prix.."$", 'CHAR_BANK_FLEECA', 9)
	else
		TriggerClientEvent('esx:showAdvancedNotification', source, 'Concessionaire', "~r~Paiement refusé", "Vous avez pas assez d'argent dans votre ~y~compte en banque", 'CHAR_BANK_FLEECA', 9)
	end
end)




ESX.RegisterServerCallback('Tikoz:ConcessSortirVehicule', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local concessrendvehicule = {}

    MySQL.Async.fetchAll('SELECT * FROM tikoz_concessgarage', {

    }, function(result)

        for i=1, #result, 1 do

            table.insert(concessrendvehicule, {
				id = result[i].id,
                name = result[i].name,
				label = result[i].label,
                prix = result[i].prix,
				body = result[i].body,
				plate = result[i].plate,
            })

        end
        cb(concessrendvehicule)
    end)
end)

RegisterServerEvent("Tikoz:ConcessionnaireBuyVeh")
AddEventHandler("Tikoz:ConcessionnaireBuyVeh", function(name, label, body, prix, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	print(name, label, body, prix, plate)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_concess' , function (account)
		if account.money >= prix then
			account.removeMoney(prix)
			TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque Société', "~b~Concessionnaire", "Vous avez acheté \n\nVéhicule : ~b~"..name.."~s~\n\nPrix ~g~"..prix.."$", 'CHAR_BANK_FLEECA', 9)

			MySQL.Async.execute('INSERT INTO tikoz_concessgarage (name, label, body, prix, plate, stored) VALUES (@name, @label, @body, @prix, @plate, @stored)', {
				['@name'] = name,
				['@label'] = label,
				['@prix'] = prix,
				['@body'] = json.encode(body),
				['@plate'] = plate,
				["@stored"] = 1,
			}, function()
			end)
		else
			TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque Société', "~b~Concessionnaire", "Vous avez pas ~r~assez d'argent~w~ dans ~b~l'entreprise", 'CHAR_BANK_FLEECA', 9)
		end
	end)
end)

RegisterServerEvent("Tikoz:ConcessionnairSetVeh")
AddEventHandler("Tikoz:ConcessionnairSetVeh", function(name, label, body, prix, plate, owner)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(owner)
	local nameped = GetPlayerName(owner)

	TriggerClientEvent('esx:showAdvancedNotification', _source, 'Concessionaire', "~b~Vente de véhicule", "Vous avez donnés les clefs \n\nVéhicule : ~b~"..label.."~s~\n\nPropriétaire : ~y~"..nameped, 'CHAR_BANK_FLEECA', 9)
	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, nom, plate, name, label, vehicle, stored, reprog) VALUES (@owner, @nom, @plate, @name, @label, @vehicle, @stored, @reprog)',
	{
		['@owner']   = xPlayer.identifier,
		["@nom"]     = nameped,
		['@plate']   = plate,
		["@name"]    = label,
		["label"]    = name,
		['@vehicle'] = json.encode(body),
		["@stored"]  = 2,
		["@reprog"]  = 0,
	}, function (rowsChanged)
	end)
	
end)

RegisterServerEvent('Tikoz:RetireTchop')
AddEventHandler('Tikoz:RetireTchop', function (id)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	MySQL.Async.execute('DELETE FROM tikoz_concessgarage WHERE id = @id',
	{
		['@id'] = id
	}, function ()
	end)
end)

ESX.RegisterServerCallback('Tikoz/getownedveh', function(source, cb, plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	owned = {}
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {
    }, function(result)
        for i=1, #result, 1 do
            table.insert(owned, {
				id = result[i].id,
                owner = result[i].owner,
				plate = result[i].plate,
            })
        end
        for k, v in pairs(owned) do
			if v.plate == plate then
				if xPlayer.identifier == v.owner then
					cb(true)
				end
			end
		end
    end)
end)
