builder/forging
	main_tool = /obj/Item/Tools/Tongs
	skill = FORGING
	allowed_in_tutorial = true

	condition(mob/m)
		var obj/forge = locate(/obj/Built/Forge) in obounds(m, 16)
		if(!forge)
			m.aux_output("You need to be by a forge.")
			return false
		if(forge.icon_state != "lit")
			m.aux_output("The forge needs to be lit.")
			return false
		return true

	metal
		name = "Metal Bar"
		icon = 'code/Mining/Metal Bar.dmi'

		desc = "A bar made from metal<br />\
				1 Metal Ore"
		tooltipRows = 2

		req = list(	MORE	=	1)
		built = /obj/Item/Bars/Metal

	hazium
		name = "Hazium Bar"
		icon = 'code/Mining/Hazium Bar.dmi'

		desc = "A bar made from hazium<br />\
				1 Hazium Ore"
		tooltipRows = 2

		req = list(	HORE	=	1)
		built = /obj/Item/Bars/Hazium

	breakdown_coin
		name = "Breakdown Coins"
		icon = 'code/Smithing/Metal Coin.dmi'

		desc = "Melt your coins into a bar<br />\
				5 Metal Coins"
		tooltipRows = 2

		req = list( COIN	=	5)
		built = /obj/Item/Bars/Metal

	breakdown_hcoin
		name = "Breakdown Hazium Coins"
		icon = 'code/Smithing/Coin.dmi'

		desc = "Melt your coins into a bar<br />\
				5 Hazium Coins"
		tooltipRows = 2

		req = list( HCOIN	=	5)
		built = /obj/Item/Bars/Hazium

	glass
		name = "Glass"
		icon = 'code/Smithing/Glass.dmi'

		desc = "An orb of glass<br />\
				1 Sand"
		tooltipRows = 2

		req = list(	SAND	=	1)
		built = /obj/Item/Ores/Glass

	crystalized_hazium
		name = "Crystalized Hazium"
		icon = 'code/Masonry/Hazium.dmi'
		icon_state = "Crystalized"

		desc = "An orb of crystalized Hazium<br />\
				1 Hazium Ore<br />\
				1 Glass<br />\
				1 Secret Item"
		tooltipRows = 4

		req = list(	SAND	=	1,
					GLASS	=	1,
					HORE	=	1)
		built = /obj/Item/Ores/Crystalized_Hazium

	bottle
		name = "Bottle"
		icon = 'code/Alchemy/Bottle.dmi'

		desc = "A bottle used for storing liquids<br />\
				1 Glass"
		tooltipRows = 2

		req = list(	GLASS	=	1)
		built = /obj/Item/Alchemy/Bottle

	glass_cup
		name = "Glass Cup"
		icon = 'code/smithing/glass_cup.dmi'
		desc = "A fancy cup</br>1 Glass"
		req = list(GLASS = 1)
		built = /obj/Item/Glass_Cup