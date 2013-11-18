
/*
	Combat ----------------------------------------------------------------------------------------
*/
mob/proc
	_attack()
		if(Locked) return false
		if(shooting) return archery_fire()

		_swing()
		spawn attack()

		Locked = true
		spawn(5) Locked = false

		return true

	//	does not do damage
	_swing()
		if(!loc || GodMode) return false

		var state = ""
		var obj/Item/main = equipment["main"]
		if(main)
			var combat_states[] = icon_states(main.icon) & list("swing", "stab")
			if(combat_states.len) state = pick(combat_states)
		if(!state) state = pick("swing", "stab")

		flick(state, src)

		return true