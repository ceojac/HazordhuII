obj
	Flag
		parent_type = /obj/Built
		icon = 'code/Flags/Flags.dmi'
		density = true

		SET_TBOUNDS("15,11 to 17,13")
		pixel_y = 10
		layer = OBJ_LAYER + 2
		attackable = true

		var capturable = true
		var access[0]

		New()
			..()
			for(var/obj/Flag/F in loc)
				if(F == src) continue
				del F

		Human
			icon_state = "Human"
			attackable = false
			Settal
				icon_state = "Settal"
				can_color = false

		Orc
			icon_state = "Orc"
			attackable = false

		Neutral
			icon_state = "Neutral"
			Settal
				icon_state = "Settal"
				can_color = false

		Bandit_Camp
			icon_state = "Undead"
			capturable = false
			can_color = false