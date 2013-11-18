mob/Admin
	verb/spawn_orc_raid()
		var facing = dir2angle(dir)
		var turfs[0]
		for(var/turf/t in nearby_turfs(16) - nearby_turfs(10))
			if(abs(angle_difference(facing, angle_to(src, t))) < 30)
				turfs += t

		for(var/n in 1 to 5)
			var mob/NPC/Orc/Warrior/m = new (loc)
			m.move_target = pick(turfs)

		for(var/n in 1 to 3)
			var mob/NPC/Orc/Archer/m = new (loc)
			m.move_target = pick(turfs)

	verb/spawn_human_raid()
		var facing = dir2angle(dir)
		var turfs[0]
		for(var/turf/t in nearby_turfs(16) - nearby_turfs(10))
			if(abs(angle_difference(facing, angle_to(src, t))) < 30)
				turfs += t

		for(var/n in 1 to 5)
			var mob/NPC/Human/Soldier/m = new (loc)
			m.move_target = pick(turfs)

		for(var/n in 1 to 3)
			var mob/NPC/Human/Archer/m = new (loc)
			m.move_target = pick(turfs)

proc/angle_to(atom/a, atom/b)
	return vec2_angle(vec2_to(vec2(a.cx(), a.cy()), vec2(b.cx(), b.cy())))