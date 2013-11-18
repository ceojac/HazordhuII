obj
	Item
		Head
			icon = 'code/Mobs/heads.dmi'
			icon_state = "White"

			Stackable = 1

			use(mob/m)
				var obj/Built/Headpike/pike = locate() in m.front()
				if(!pike) return
				if(locate(/obj/Item/Head) in pike) return
				pike.icon_state = icon_state
				Move(pike)