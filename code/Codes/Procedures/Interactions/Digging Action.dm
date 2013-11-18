
/*
	Dirt-packing & Digging  ----------------------------------------------------------------------
*/
mob/proc
	is_dirt(obj/Item/Ores/Dirt/o) return istype(o)

	has_shovel() return is_equipped(/obj/Item/Tools/Shovel)

	_dig(turf/t)
		if(Locked) return
		if(!t) t = cloc()
		if(!isturf(t)) return
		if(has_shovel())
			if(t.dig(src))
				used_tool()
		else t.forage(src)

obj/Item/Tools/Shovel/use(mob/m) m._dig()