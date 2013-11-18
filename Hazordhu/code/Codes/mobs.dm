proc/is_animal(mob/Animal/m) return istype(m)
proc/is_mortal(mob/mortal/m) return istype(m)
proc/is_humanoid(mob/humanoid/m) return istype(m)
proc/is_npc(mob/NPC/m) return istype(m)
proc/is_player(mob/player/m) return istype(m)

mob
	//	Distinguishes living things from things like corpses
	mortal

	Animal/parent_type = /mob/mortal

	//	This lets us distinguish people from animals
	humanoid/parent_type = /mob/mortal

	NPC/parent_type = /mob/humanoid

	//	This lets us distinguish players from animals
	player/parent_type = /mob/humanoid

