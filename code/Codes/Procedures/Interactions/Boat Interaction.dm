/*
	Boats --------------------------------------------------------------------
*/
mob/proc
	is_boat(obj/Built/Boat/boat) return istype(boat)

	has_paddle() return is_equipped(/obj/Item/Tools/Paddle)
	has_hammer() return is_equipped(/obj/Item/Tools/Hammer)

	_enter_boat(obj/Built/Boat/boat) if(is_boat(boat)) return boat.get_on(src)
	_exit_boat(obj/Built/Boat/boat) if(is_boat(boat)) return boat.get_off(src)
	_fix_boat(obj/Built/Boat/boat) if(is_boat(boat) && has_hammer()) return boat.repair(src)
