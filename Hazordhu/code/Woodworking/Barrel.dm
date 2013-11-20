obj/Built
	Barrel
		SET_TBOUNDS("9,4 to 24,9")

		icon = 'Barrel.dmi'

		New()
			..()
			if(!filled && icon_state)
				filled = 10

		var filled = 0

		interact_right(mob/player/m)
			if(filled)
				m.aux_output("The barrel has [filled] bottle-full\s of [icon_state] in it.")
				return

			else
				var obj/Item/Bucket/Water/w = locate() in m
				if(!w)
					m.aux_output("You need a bucket of water to fill the barrel with.")
					return

				m.emote("begins filling the barrel with water")
				m._do_work(100)
				m.emote("begins fill the barrel with water")
				del w
				new /obj/Item/Bucket (m)
				new /obj/Built/Barrel/Water (loc)
				del src

		interact(mob/player/m)
			if(filled)
				var obj/Item/Alchemy/Bottle/b
				for(b in m) if(!b.icon_state) break

				if(!b)
					m.aux_output("You need an empty bottle to fill with [icon_state].")
					return

				else
					m.aux_output("You fill your bottle with [icon_state]. \...")
					m.lose_item(b)
					switch(icon_state)
						if("water") new /obj/Item/Alchemy/Bottle/Water (m)
						if("wine")  new /obj/Item/Alchemy/Bottle/Wine (m)
						if("beer")  new /obj/Item/Alchemy/Bottle/Beer (m)
					deplete(m)
			..()

		proc/deplete(mob/player/m)
			filled --
			if(!filled)
				m.aux_output("The barrel is now empty.")
				new /obj/Built/Barrel (loc)
				del src
			else m.aux_output("The barrel has [filled] bottle-full\s of [icon_state] left.")

		Water
			name = "Barrel of Water"
			icon_state = "water"

		Wine
			name = "Barrel of Wine"
			icon_state = "wine"

		Beer
			name = "Barrel of Beer"
			icon_state = "beer"

obj/Item/Alchemy/Bottle
	proc/drank(mob/m)

	Wine
		icon_state = "wine"
		use(mob/m) if(loc == m)
			if(m.Thirst)
				m.emote("starts drinking wine from the bottle")
				m.Locked = 1
				m.status_overlay("thirst")

				for(var/n in 1 to 20)
					sleep(1)
					m.Thirst -= 0.5
					if(m.Thirst <= 0)
						break

				m.status_overlay_remove("thirst")
				m.emote("finishes drinking wine from the bottle")
				m.Locked = 0

				drank(m)
				new /obj/Item/Alchemy/Bottle (m)
				del src

			else m << "You don't need to drink."

	Beer
		icon_state = "beer"
		use(mob/player/m) if(loc == m)
			if(m.Thirst)
				m.emote("starts drinking beer from the bottle")
				m.Locked = 1
				m.status_overlay("thirst")

				for(var/n in 1 to 20)
					sleep(1)
					m.lose_thirst(0.5)
					if(!m.Thirst)
						break

				m.status_overlay_remove("thirst")
				m.Locked = 0
				m.emote("finishes drinking beer from the bottle")

				drank(m)
				new /obj/Item/Alchemy/Bottle (m)
				del src

			else m.aux_output("You don't need to drink.")