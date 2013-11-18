mob
	proc/HeritageIcon()
		var heritages[] = list(
			"Human" = list("Southshores", "Plainsman", "Northern", "Chiprock"),
			"Orc" = list("Stonehammer", "Warcry", "Windhowl"))

		for(var/race in heritages)
			if(Heritage in heritages[race])
				Race = race
				break

		switch(Race)
			if("Human")
				SkinType = /obj/Item/Skin/Human_Skin
				MeatType = /obj/Item/Food/Meat/Human_Meat
				switch(Heritage)
					if("Southshores")	icon = gender == MALE ? 'code/Mobs/Human/m_black.dmi' : 'code/Mobs/Human/f_black.dmi'
					if("Plainsman")		icon = gender == MALE ? 'code/Mobs/Human/m_tan.dmi'   : 'code/Mobs/Human/f_tan.dmi'
					if("Northern")		icon = gender == MALE ? 'code/Mobs/Human/m_white.dmi' : 'code/Mobs/Human/f_white.dmi'
					if("Chiprock")		icon = gender == MALE ? 'code/Mobs/Human/m_pale.dmi'  : 'code/Mobs/Human/f_pale.dmi'

			if("Orc")
				SkinType = /obj/Item/Skin/Orc_Skin
				MeatType = /obj/Item/Food/Meat/Orc_Meat
				switch(Heritage)
					if("Stonehammer")	icon = gender == MALE ? 'code/Mobs/Orc/m_stonehammer.dmi' : 'code/Mobs/Orc/f_stonehammer.dmi'
					if("Warcry")		icon = gender == MALE ? 'code/Mobs/Orc/m_warcry.dmi'		 : 'code/Mobs/Orc/f_warcry.dmi'
					if("Windhowl")		icon = gender == MALE ? 'code/Mobs/Orc/m_windhowl.dmi'	 : 'code/Mobs/Orc/f_windhowl.dmi'

			if("Undead")
				icon = 'code/Mobs/Skeleton.dmi'
				MeatType = /obj/Item/Bone

		Gethair()