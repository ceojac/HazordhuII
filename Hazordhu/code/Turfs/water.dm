proc/iswater(turf/Environment/t) return istype(t) && t.is_water
proc/islava(turf/Environment/t) return istype(t) && t.is_lava
proc/is_water(t) return iswater(t)
proc/is_lava(t) return islava(t)

turf/Environment
	var is_water = false
	var is_lava = false

	var tmp/is_deep_water = false

	proc/is_frozen() return is_water && icon == 'code/Turfs/ice.dmi' && icon_state != "chipped"
	proc/is_bridged() return locate(/obj/Built/Floors) in src
	proc/is_flowing() return icon_state == "river"

	Lava/is_lava = true

	Enter(o)
		if(!is_water && !is_lava) return ..()
		if(istype(o, /ray/interact)) return true
		if(istype(o, /mob/title)) return false

		density = true

		if(is_bridged())// || is_water && icon == 'code/turfs/water.dmi' && (istype(o, /obj/Built/Boat) || (is_frozen() && icon_state != "Fall")))
			density = false
			return ..()

		else if(is_frozen() && icon_state != "Fall")
			density = false
			return ..()

		else if(is_water && istype(o, /obj/Built/Boat))
			if(icon == 'code/turfs/ice.dmi' && icon_state == "Fall")
				return false
			density = false
			return ..()

		else if(is_humanoid(o))
			var mob/humanoid/m = o

			if(m.GodMode)
				return true

			else if(m.boat)
				density = false
				return ..()

			else if(m.Waterwalk && icon == 'code/Turfs/Water.dmi' && icon_state != "Fall")
				density = false
				return ..()

		else return ..()

	Water
		is_water = true
		is_deep_water = null

		interact(mob/m) m._gather(src)
		interact_right(mob/m) m._drink(src)

		Entered(mob/mortal/m)
			if(istype(m) && icon_state == "chipped")
				if(m.GodMode) return
				if(prob(50)) m.die("falling through the ice")

	Ocean
		is_water = true
		is_deep_water = null

	water_rock
		parent_type = /obj
	//	is_water = true

	proc/is_deep_water()
		if(isnull(is_deep_water))
			is_deep_water = false
			if(is_water)
				is_deep_water = true
				var nearby[] = nearby_turfs(2)
				for(var/index in 1 to nearby.len)
					var turf/Environment/t = nearby[index]
					if(!t.is_water)
						is_deep_water = false
						break
		return is_deep_water