var transparent_stat_bar_icon = generate_transparent_stat_bar_icon()
proc/generate_transparent_stat_bar_icon()
	var opacity = 0.3

	var icon/i = icon('HUD icons.dmi')
	for(var/stat in list("health", "energy", "hunger", "thirst"))
		var filled = stat
		var empty = "[stat] empty"

		var icon/tf = icon('HUD icons.dmi', filled)
		tf.MapColors(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0, opacity, 0,0,0,0)

		var icon/te = icon('HUD icons.dmi', empty)
		te.MapColors(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0, opacity, 0,0,0,0)

		i.Insert(tf, "[filled] hidden")
		i.Insert(te, "[empty] hidden")
	return fcopy_rsc(i)

mob/player
	var tmp/hud/bar
		health/health_bar
		energy/energy_bar
		hunger/hunger_bar
		thirst/thirst_bar

	Stat()
		..()
		if(Made)
			if(!health_bar)
				health_bar = new (src)
				energy_bar = new (src)
				hunger_bar = new (src)
				thirst_bar = new (src)

			var bars[] = list(
				health = health_bar,
				energy = energy_bar,
				hunger = hunger_bar,
				thirst = thirst_bar)

			var percents[] = list(
				health = Health / MaxHealth,
				energy = Stamina / MaxStamina,
				hunger = 1 - Hunger / 100,
				thirst = 1 - Thirst / 100)

			var force_show = has_key("x")

			for(var/stat in bars)
				var hud/bar/stat/bar = bars[stat]

				if(force_show || percents[stat] < 0.7)
					bar.fade = false
				else bar.fade = true

				bar.set_value(percents[stat])

	proc/show_statbars() for(var/hud/bar/stat/bar in list(health_bar, energy_bar, hunger_bar, thirst_bar)) bar.fade = false
	proc/hide_statbars() for(var/hud/bar/stat/bar in list(health_bar, energy_bar, hunger_bar, thirst_bar)) bar.fade = true

	key_down(k)
		if(k == "x")
			show_statbars()
		else ..()

	key_up(k)
		if(k == "x")
			hide_statbars()
		else ..()

hud/bar
	stat
		build_parts()
			..()
			for(var/hud/bar/part/part in parts)
				part.icon = transparent_stat_bar_icon

		var fade = false

		empty_state()
			. = ..()
			if(fade) . += " hidden"

		fill_state()
			. = ..()
			if(fade) . += " hidden"


	health
		parent_type = /hud/bar/stat
		name = "health"
		x = "CENTER-3"
		y = "NORTH-2"

	energy
		parent_type = /hud/bar/stat
		name = "energy"
		x = "CENTER+1"
		y = "NORTH-2"
		px = 16

	hunger
		parent_type = /hud/bar/stat
		name = "hunger"
		x = "CENTER-3"
		y = "SOUTH+2"

	thirst
		parent_type = /hud/bar/stat
		name = "thirst"
		x = "CENTER+1"
		y = "SOUTH+2"
		dir = EAST
		px = 16