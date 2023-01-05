ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('Tikoz:GetVehGarage', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local garageowner = {}
    local iden = xPlayer.getIdentifier()

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {

    }, function(result)

        for i=1, #result, 1 do

            table.insert(garageowner, {
				id = result[i].id,
                nom = result[i].nom,
                prenom = result[i].prenom,
                owner = result[i].owner,
                name = result[i].name,
                label = result[i].label,
                vehicle = result[i].vehicle,
                plate = result[i].plate,
                type = result[i].type,
                stored = result[i].stored,
            })
        end
        cb(garageowner, iden)
    end)
end)

ESX.RegisterServerCallback('Tikoz:GarageDespawnVeh', function (source, cb, plate)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate,
	}, function (result)
		if result[1] ~= nil then
			local vehmod = json.decode(result[1].plate)
				MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
                    ["@plate"] = plate,
					['@stored'] = 1
				}, function (rowsChanged)
				
					cb(true)
				end)
		else
			cb(false)
		end
	end)
end)


RegisterServerEvent('Tikoz:GarageSortVeh')
AddEventHandler('Tikoz:GarageSortVeh', function (plate, etat, pros)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    
    if etat == "sort" then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = plate,
        }, function (result)
            if result[1] ~= nil then
                local vehmod = json.decode(result[1].plate)
                MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored WHERE owner = @owner AND plate = @plate', {
                    ['@owner'] = xPlayer.identifier,
                    ["@plate"] = plate,
                    ['@stored'] = 2
                }, function (rowsChanged)
                end)
            end
        end)
    elseif etat == "rentre" then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
            ['@owner'] = xPlayer.identifier,
            ['@plate'] = plate,
        }, function (result)
            if result[1] ~= nil then
                local vehmod = json.decode(result[1].plate)
                MySQL.Async.execute('UPDATE owned_vehicles SET stored = @stored, vehicle = @vehicle WHERE owner = @owner AND plate = @plate', {
                    ['@owner'] = xPlayer.identifier,
                    ["@plate"] = plate,
                    ["@vehicle"] = json.encode(pros),
                    ['@stored'] = 1
                }, function (rowsChanged)
                end)
            end
        end)
    end
end)

RegisterServerEvent('Tikoz:GarageNewName')
AddEventHandler('Tikoz:GarageNewName', function (newName, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
        ['@owner'] = xPlayer.identifier,
        ['@plate'] = plate,
    }, function (result)
        if result[1] ~= nil then
            local vehmod = json.decode(result[1].plate)
            MySQL.Async.execute('UPDATE owned_vehicles SET label = @label WHERE owner = @owner AND plate = @plate', {
                ['@owner'] = xPlayer.identifier,
                ["@plate"] = plate,
                ['@label'] = newName
            }, function (rowsChanged)
            end)
        end
    end)
end)

RegisterServerEvent('Tikoz:FourriereSortVehPayant')
AddEventHandler('Tikoz:FourriereSortVehPayant', function (veh, pi)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local money = xPlayer.getMoney()
    print(money)
    if money >= Config.PrixFourriere then
        xPlayer.removeMoney(Config.PrixFourriere)
        TriggerClientEvent('Tikoz:FourriereSortVehPayant', _source, veh, pi)
    else
        TriggerClientEvent('esx:showAdvancedNotification', _source, 'Fourrière', "~r~Paiement refusé", "Vous avez pas ~r~assez d'argent~s~ sur vous", 'CHAR_BANK_FLEECA', 9)
    end
 
end)
