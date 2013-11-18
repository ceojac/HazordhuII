mob
	var
		surname
		list
			family = list()

	NPC
		Baby
			var/age = 0
			icon='Baby.dmi'
			saveable = 1
			New(x,race,namer,mommy,daddy,herit,hair)
				Heritage = herit
				HairColor = hair
				name = namer
				mom = mommy
				dad = daddy
				mom_name = "Mommy"
				dad_name = "Daddy"
				icon_state = race
				Race = icon_state
				gender = pick("male", "female")
				switch(race)
					if("Human")
						SkinType=/obj/Item/Skin/Human_Skin
						MeatType=/obj/Item/Food/Meat/Human_Meat
						Speaking="Common"
					if("Orc")
						SkinType=/obj/Item/Skin/Orc_Skin
						MeatType=/obj/Item/Food/Meat/Orc_Meat
						Speaking="Orc"

			proc
				Age()
					age ++
					if(age >= 50)
						switch(icon_state)
							if("Human")
								new/mob/NPC/Human(loc,name,mom,dad,gender,Heritage,HairColor)
							if("Orc")
								new/mob/NPC/Orc(loc,name,mom,dad,gender,Heritage,HairColor)
						del(src)