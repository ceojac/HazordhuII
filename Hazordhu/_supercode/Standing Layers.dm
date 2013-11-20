//	My side-map layering system

atom/movable
	//	Set this to true if you want the atom to
	//	layer like it's standing up
	var standing
	var bottom_offset

	proc/update_layer()
		var max_py = world.maxy * tile_height
		if(!max_py) return

		//	The base layer
		layer = MOB_LAYER

		//	px / max_py
		if(loc) layer -= (py() + bottom_offset) / max_py

	New()
		..()
		standing && update_layer()

	Move()
		. = ..()
		standing && update_layer()

mob
	standing = true
	Corpse
		standing = false
		layer = TURF_LAYER + 2


obj/click_void/standing = false

obj
	Mining/Deposits/standing = true
	Woodcutting/standing = true
	Flag/standing = true
	Built
		standing = true
		Boat/standing = false
		Path/standing = false
		Floor/standing = false
		Stone_Floor/standing = false
		Sandstone_Floor/standing = false
		tutorial_circle/standing = false
		Transporter/standing = false
		Bed/standing = false
		firepit/standing = false