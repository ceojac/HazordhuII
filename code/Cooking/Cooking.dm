obj
	Item
		Food
			Prep
				Hunger = 5
				icon = 'Prep.dmi'
				Dough
					icon = 'Recipes.dmi'
					icon_state = "dough"
				Chopped_Lettif
					icon_state = "Chopped Lettif"
				Sliced
					Tumeta
						icon_state = "Sliced Tumeta"
					Karet
						icon_state = "Sliced Karet"
					Puteta
						icon_state = "Sliced Puteta"
				Diced
					Tumeta
						icon_state = "Diced Tumeta"
					Karet
						icon_state = "Diced Karet"
					Puteta
						icon_state = "Diced Puteta"

				use_alt(mob/m)
					if(!m.Locked && (loc == m || bounds_dist(src, m) <= 16))
						if(istype(src, /obj/Item/Food/Prep/Sliced))
							if(m.has_knife())
								m.used_tool()
								m.emote("starts dicing the [src]")
								m._do_work(30)
								m.emote("finishes dicing the [src]")
								m.lose_item(src)
								m.get_item("/obj/Item/Food/Prep/Diced/[name]")

			Cooking
				icon = 'Recipes.dmi'
				Bread
					Hunger = 25
					icon_state = "bread"
				Sandwich
					Hunger =  50
					icon_state = "sandwich"
				Cake
					icon_state = "cake"
					use_alt(mob/m)
						if(m.Locked) return
						if(loc == m)
							if(m.has_knife())
								m.used_tool()
								m.emote("begins slicing the cake")
								m._do_work(35)
								m.emote("finishes slicing the cake")
								m.lose_item(src)
								for(var/n in 1 to 5) m.get_item(/obj/Item/Food/Cooking/Cake_Slice)

				Cake_Slice
					Stackable = 1
					Hunger = 20
					icon_state = "cake slice"

				Pie
					icon_state = "pie"
					use_alt(mob/m)
						if(m.Locked) return
						if(loc == m && m.has_knife())
							m.used_tool()
							m.emote("begins slicing the pie")
							m._do_work(35)
							m.emote("finishes slicing the pie")
							m.lose_item(src)
							for(var/n in 1 to 5) m.get_item(/obj/Item/Food/Cooking/Pie_Slice)

				Pie_Slice
					Stackable = 1
					Hunger = 20
					icon_state = "pie slice"
				Cheese
					Hunger = 15
					icon_state = "cheese"
				Muffin
					Stackable = 1
					Hunger = 10
					icon_state = "muffin"
				Bacon
					Hunger = 10
					icon_state = "bacon"
				Cookie
					Stackable = 1
					Hunger = 10
					icon_state = "cookie"

obj/Item/Bowl/Food
	var Hunger
	use(mob/player/m)
		m.aux_output("You eat the [src].")
		m.lose_hunger(Hunger)
		m.lose_item(src)
		m.get_item(/obj/Item/Bowl)

	Stew
		Hunger = 40
		icon_state = "Stew"
	Ice_Cream
		Hunger = 15
		icon_state = "Ice Cream"
	Tumeta_Sauce
		Hunger = 10
		icon_state = "Tumeta Sauce"
	Alfredo_Sauce
		Hunger = 10
		icon_state = "Alfredo Sauce"
	Hollandaise_Sauce
		Hunger = 10
		icon_state = "Hollandaise Sauce"

obj/Item/Plate
	var Hunger
	use(mob/player/m)
		m.aux_output("You eat the [src].")
		m.lose_hunger(Hunger)
		m.lose_item(src)
		m.get_item(/obj/Item/Plate)

	Salad
		Hunger = 30
		icon_state = "Salad"
	Pasta
		Hunger = 30
		icon_state = "Pasta"
	Tumeta_Pasta
		Hunger = 40
		icon_state = "Pasta Tumeta"
	Alfredo_Pasta
		Hunger = 40
		icon_state = "Pasta Alfredo"
	Fried_Egg
		Hunger = 25
		icon_state = "Fried Egg"

obj/Item/Farming/crop
	use_alt(mob/m)
		if(!m.Locked && (loc == m || bounds_dist(src, m) <= 16))
			if(istype(src, /obj/Item/Farming/crop/Puteta) || istype(src, /obj/Item/Farming/crop/Lettif) || istype(src, /obj/Item/Farming/crop/Karet) || istype(src,/obj/Item/Farming/crop/Tumeta))
				if(m.has_knife())
					m.used_tool()
					m.emote("starts slicing the [src]")
					m._do_work(30)
					m.emote("finishes slicing the [src]")

					var obj/Item/result
					if(!istype(src, /obj/Item/Farming/crop/Lettif))
						result = text2path("/obj/Item/Food/Prep/Sliced/[name]")
					else result = /obj/Item/Food/Prep/Chopped_Lettif

					m.lose_item(src)
					m.get_item(result)