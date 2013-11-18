
/*
	Readin' --------------------------------------------------------------------
*/
mob/proc
	is_sign(obj/Built/Signs/o)
		return istype(o)

	_read(obj/Built/Signs/o) if(is_sign(o)) return o.read(src)
	_write(obj/Built/Signs/o) if(is_sign(o)) return o.write(src)