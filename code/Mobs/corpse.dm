mob/Corpse
	density = false
	layer = MOB_LAYER - 2
	Flammable = true
	Dead = true

	var ol[0]
	var deg
	var hair_overlay
	var head_state
	var is_animal

	New(mob/m)
		..()
		if(istype(m, /mob/Animal))
			name = "Dead [m]"
			is_animal = true

		set_loc(m.loc)

		SkinType = m.SkinType
		MeatType = m.MeatType

		if(is_humanoid(m))
			var mob/humanoid/h = m
			h.icon_turn(pick(90, -90))
			icon = h.flat_icon()
			icon_state = h.icon_state
			rotated_angle = h.rotated_angle
			h.icon_turn(0)
		else
			var icon/i = icon(m.icon, m.icon_state)
			i.Turn(pick(90, -90))
			icon = i

		dir = NORTH

	#if PIXEL_MOVEMENT
		step_x = m.step_x
		step_y = m.step_y
	#endif

		pixel_x = m.pixel_x
		pixel_y = m.pixel_y

		SET_TBOUNDS(m.bounds)

		head_state = get_head(m)

		if(istype(loc, /turf/Environment/Water)) if(get_season() != WINTER) del src
		if(istype(loc, /turf/Environment/Ocean)) del src

		if(istype(m, /mob/Animal/Flargl))
			pixel_x -= 32
			pixel_y -= 32

		spawn(10 * MINUTE)
			if(findtext(name, "Corpse"))
				skelefy()
				sleep HOUR
			del src

	interact(mob/humanoid/m)
		Skin(m)

	proc
		skelefy()
			if(is_animal) return
			var icon/i = icon('code/Mobs/skeleton.dmi')
			i.Turn(rotated_angle)
			icon = i
			name = "Skeleton"
			head_state = "skeleton"
			MeatType = /obj/Item/Bone
			SkinType = null
			overlays.Cut()

		Skin(mob/humanoid/skinner)
			if(skinner.Locked)				return

			if(skinner.has_hatchet())
				skinner.emote("starts beheading the [src]")
				skinner._do_work(30)
				skinner.emote("finishes beheading the [src]")
				skinner.used_tool()

				var obj/Item/Head/h = new (loc)
				h.icon_state = head_state || icon_state
				set_loc()

			else if(skinner.has_knife())
				skinner.emote("starts skinning the [src]")
				skinner._do_work(30)
				skinner.emote("finishes skinning the [src]")
				skinner.used_tool()

				if(SkinType)
					if(prob(33))
						new SkinType (loc)
					new SkinType (loc)

				if(MeatType)
					new MeatType(loc)

				if(is_animal)
					if(prob(50))
						set_loc()
				else if(name == "Skeleton")
					if(prob(75))
						set_loc()
				else skelefy()

				return true

		get_head(mob/m)  // The icon state for a head that's given.
			switch(m.type)
				if(/mob/Animal/Flargl)			return "flargl"
				if(/mob/Animal/Troll)			return "troll"
				if(/mob/Animal/Flurm)			return "flurm"
				if(/mob/Animal/Flurm/Flurm1)	return "flurm1"
				if(/mob/Animal/Grawl)			return "grawl"
				if(/mob/Animal/Grawl/North) 	return "ngrawl"
				if(/mob/Animal/Olihant) 		return "olihant"
				if(/mob/Animal/Bux)				return "bux"
				if(/mob/Animal/Rar)				return "rar"
				if(/mob/Animal/Agriner)			return "agriner"
				if(/mob/NPC/Baby)				return "baby_[copytext(lowertext(m.Race), 1, 2)]"
				else
					switch(m.Race)
						if("Human") switch(m.Heritage)
							if("Southshores")	return "Black"
							if("Plainsman")		return "Tan"
							if("Northern")		return "White"
							if("Chiprock")		return "Pale"
						if("Orc") switch(m.Heritage)
							if("Stonehammer")	return "Stonehammer"
							if("Warcry")		return "Warcry"
							if("Windhowl")		return "Windhowl"
			if(istype(m, /mob/NPC/Zombie))		return "zombie"