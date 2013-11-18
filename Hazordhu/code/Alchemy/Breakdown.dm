obj
	Alchemy/Breakdown
		icon='code/Alchemy/Element.dmi'
		New()
			..()
			Type = getType()

		DblClick()
			var mob/player/player = usr

			if(player.Locked) return
			if(ispath(Type))
				var/obj/Item/o = locate(Type) in player

				if(o)
					if(o.Stacked >= 5)
						player.lose_item(o, 5)

					else
						player.aux_output("You need more [lowertext(name)]s.")
						return

				else
					player.aux_output("You need 5 [lowertext(name)]s to make this.")
					return

			else if(istype(Type, /list))
				var items[0], total = 0

				for(var/obj/Item/o in player)
					if(o.type in Type)
						items += o
						total += o.Stacked

				if(items.len && total >= 5)
					total = 5
					for(var/obj/Item/o in items)
						for(var/n in 1 to o.Stacked)
							player.lose_item(o)
							total --
							if(total <= 0) break
						if(total <= 0) break
				else
					if(!items.len)		player.aux_output("You need 5 [lowertext(name)]s to make this.")
					else if(total < 5)	player.aux_output("You need more [lowertext(name)]s.")
					return

			player.emote("begins breaking down [src] into its element")
			player._do_work(30)
			player.emote("completes the [src] element")
			player.get_item("/obj/Item/Alchemy/Element/[name]")

		Metal	icon_state = "Metal"
		Hazium	icon_state = "Hazium"
		Clay	icon_state = "Clay"
		Stone	icon_state = "Stone"
		Dirt	icon_state = "Dirt"
		Sand	icon_state = "Sand"
		Meat	icon_state = "Meat"
		Plant	icon_state = "Plant"
		Wood	icon_state = "Wood"

		proc/getType() switch(name)
			if("Metal")		return /obj/Item/Ores/Metal
			if("Hazium")	return /obj/Item/Ores/Hazium
			if("Clay")		return /obj/Item/Ores/Clay
			if("Stone")		return /obj/Item/Ores/Stone
			if("Dirt")		return /obj/Item/Ores/Dirt
			if("Sand")		return /obj/Item/Ores/Sand
			if("Meat")		return typesof(/obj/Item/Food/Meat)
			if("Plant")		return typesof(/obj/Item/Farming)
			if("Wood")		return typesof(/obj/Item/Wood)

obj/Built
	Counter
		Breakdown
			name = "Breakdown Counter"
			icon_state = "Breakdown"