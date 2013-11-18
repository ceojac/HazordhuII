mob/player/key_down(k)
	if(k == "e" || k == "space")
		if(Locked) return
		act()
		if(_interact()) return
		if(!handcuffs()) _swing()
	else ..()

/*
	Main interaction, the caller of everything else ---------------------------------------------
*/
mob
	proc/can_interact()
		return !Locked

	proc/_interact() if(can_interact())
		. = 0

		var atom/o

		if(combat_mode)
			//	attacking stuff
			if(_attack()) return 1

		else
			var position[] = front(16) - list(mount, boat)
			for(o in position) if(!raycast_to(o, /ray/interact)) position -= o
			if(!position.len) return false

			var action = has_key("alt") ? "interact right" : "interact"
			for(o in position) if(hascall(o, action) && call(o, action)(src)) return true

			//	plowing fields
			for(o in position) if(_plow_path(o)) return 1

			//	pinning fur
			for(o in position) if(_pin_fur(o)) return 1

	//	Shows the work overlay and calculates the bonus time
	proc/_do_work(duration)
		Locked = true

		var mob/player/p = src
		if(istype(p))
			if(p.isSubscriber || p.isBYONDMember)
				duration /= 2

		status_overlay("work", duration)
		sleep(duration)
		Locked = false

/*
	Cookin' --------------------------------------------------------------------------
*/
mob/proc
	has_pan() return is_equipped(/obj/Item/Tools/Pan)


/*
	Open/close stuff --------------------------------------------------------------------
*/

mob/proc
	has_staff() return is_equipped(/obj/Item/Tools/Staff)
	has_scissors() return is_equipped(/obj/Item/Tools/Scissors)
/*
	Tanning Frames  ----------------------------------------------------------------------------------------
*/
mob/proc
	_pin_fur(obj/Built/Tanning_Frame/o) if(istype(o)) o.Pin(src)

/*
	Forges & Ovens  ----------------------------------------------------------------------------------------
*/
mob/proc
	has_tongs()
		if(is_equipped(/obj/Item/Tools/Tongs)) return true
		return false

	is_forge(obj/Built/Forge/o)
		return istype(o)

	is_oven(obj/Built/Oven/o)
		return istype(o)


/*
	Items ----------------------------------------------------------------------------------------
*/
mob/proc
	_pick_up(obj/Item/i, all) if(istype(i))
		if(all)
			return i.GetAll(src)
		return i.Get(src)
