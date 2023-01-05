Config = {}

Config.Blip = {

    UseBlip = true,

    Pos = vector3(-36.38, -1100.34, 26.42),

    Id = 225, -- Vous pouvez changer le blip et la couleur avec : https://docs.fivem.net/docs/game-references/blips/
    
    Taille = 0.8,
    
    Couleur = 45,

    Nom = "Concessionaire"
}

Config.Pos = {

	VehiculeExpo = true,

	BuyVehicule = true,

	SortiVehicule = vector4(-36.38, -1100.34, 26.42, 338.01),

	Catalogue = vector3(-56.79, -1096.77, 25.42),

    Menu = vector3(-31.31, -1106.68, 25.42),

    Coffre = vector3(-40.32, -1088.2, 25.42),

    Boss = vector3(-31.67, -1113.94, 25.42),

    Vestiaire = vector3(-26.54, -1090.11, 25.42)

}

Config.Car = {
    
	Voiture = "sultan3",

	Label = "Sultan RS Classique",

	prix = 100000,

    Pos1 = vector4(-44.32, -1095.58, 26.42, 139.57),

    Voiture2 = "sultan",

	Label2 = "Sultan",

	prix2 = 50000,

    Pos2 = vector4(-47.51, -1093.38, 26.42, 135.79),

    Voiture3 = "baller7",

	Label3 = "Baller 7",

	prix3 = 75000,

    Pos3 = vector4(-47.68, -1102.1, 26.42, 309.75)

}

function Holograms()
		while true do
			inter = 1000
			if GetDistanceBetweenCoords(-45.83, -1098.59, 26.42, GetEntityCoords(PlayerPedId())) < 10.0 then
				Draw3DText( -44.32, -1095.58, 25.12, "Sultan 3 : ~g~100 000$", 4, 0.1, 0.1)
				Draw3DText( -47.51, -1093.38, 25.12, "Sultan : ~g~50 000$", 4, 0.1, 0.1)
				Draw3DText( -47.68, -1102.1, 25.22, "Baller Series 7 : ~g~75 000$", 4, 0.1, 0.1)		
				inter = 0
			end

			if Config.Pos.BuyVehicule == true then
				if GetDistanceBetweenCoords(-44.32, -1095.58, 25.12, GetEntityCoords(PlayerPedId())) < 3 then
					TextBuy( -44.32, -1095.58, 24.90, "Appuie sur ~b~[E]~s~ pour ~b~l'acheter", 4, 0.1, 0.1)
					inter = 0

					if IsControlJustPressed(1, 51) then
						buyvoiture()
					end
				end
				if GetDistanceBetweenCoords(-47.51, -1093.38, 25.12, GetEntityCoords(PlayerPedId())) < 3 then
					TextBuy( -47.51, -1093.38, 24.90, "Appuie sur ~b~[E]~s~ pour ~b~l'acheter", 4, 0.1, 0.1)
					inter = 0
					if IsControlJustPressed(1, 51) then
						buyvoiture2()
					end
				end
				if GetDistanceBetweenCoords(-47.68, -1102.1, 25.62, GetEntityCoords(PlayerPedId())) < 3 then
					TextBuy( -47.68, -1102.1, 25.42, "Appuie sur ~b~[E]~s~ pour ~b~l'acheter", 4, 0.1, 0.1)
					inter = 0
					if IsControlJustPressed(1, 51) then
						buyvoiture3()
					end
				end
			else
			end

		Wait(inter)
	end
end

Config.Tenue = {
	Homme = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 65, ['torso_2'] = 0,
		['arms'] = 0,
		['pants_1'] = 38, ['pants_2'] = 0,
		['shoes_1'] = 25, ['shoes_2'] = 0,
	},

	Femme = {
		['tshirt_1'] = 38,['tshirt_2'] = 0,
		['torso_1'] = 57, ['torso_2'] = 0,
		['arms'] = 21, ['arms_2'] = 0,
		['pants_1'] = 11, ['pants_2'] = 1,
		['shoes_1'] = 49, ['shoes_2'] = 0,
	}
}