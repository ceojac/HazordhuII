
//remove the shadow type from the friendly_types list in the Undead Army file and the zombie file when you aren't using this
mob/NPC/Undead/Shadow
	density = 0
	icon = 'code/_RP Events/HoD/shadow.dmi'
	name = "Shadow"
	Strength = 30
	Health = 40

mob/Animal/Ruff/Hellhound
	icon='code/_RP Events/HoD/hellhound.dmi'
	diet = MEAT & CORPSE
	mood="aggressive"
	Health=200
	Strength=40

obj
	prop_corpse
		density = 0
		name = "Corpse"
		New()
		//	icon = pick('code/Mobs/Human/F_Mob.dmi','code/Mobs/Human/Mob.dmi','code/Mobs/Orc/F_Mob.dmi','code/Mobs/Orc/Mob.dmi')
			var/icon/i=icon(icon, icon_state)
			var/deg = rand(45,315)
			i.Turn(deg)
			icon = i

	Item
		Armour
			Helmet
				draolus_helm
					name = "Mysterious Helmet"
					icon = 'code/_RP Events/HoD/special.dmi'
					Defense = 25
					Type = "Plate"
