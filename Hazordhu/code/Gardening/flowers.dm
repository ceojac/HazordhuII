
obj
	Item
		Flower
			icon = 'flowers.dmi'
			Yilow
				icon_state = "Yilow"
			Elfid
				icon_state = "Elfid"
			Hazbiscus
				icon_state = "Hazbiscus"
			Marinella
				icon_state = "Marinella"
			Ruze
				icon_state = "Ruze"

	Flowers
		icon = 'flowers.dmi'
		density = 0

		season_update(season)
			..()
			switch(season)
				if(WINTER)	icon_state = "1[initial(icon_state)]"
				else		icon_state = initial(icon_state)

		Yilows
			icon_state = "yilows"

		Elfids
			icon_state = "elfids"

		Hazbisci
			density = 1
			icon_state = "hazbisci"
			SET_TBOUNDS("7,7 to 28,10")

		Ruzebush
			density = 1
			icon_state = "ruzebush"
			SET_TBOUNDS("3,7 to 30,9")