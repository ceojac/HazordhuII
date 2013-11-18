//--------------------------------
// LIGHTING Event
//--------------------------------

/*
	The LIGHTING flag can be found under _defines.dm at the root of the source
*/

event/lighting
	var
		global_light = 10 // The light level for the world
		shaders[0]
		tmp/pre_light


	execute()
		..()
		global_light = time2light()
		if(global_light != pre_light)
			spawn for(var/client/c) c.client_light()
			pre_light = global_light

turf
//	name = "Nothing Important"
	var light_obj/light_obj

// light datum

	proc/get_light_obj()
		if(!light_obj)
			light_obj = new (src)
			light_obj.layer = 102

		return light_obj

light_obj
	parent_type = /obj
	mouse_opacity = 0

	icon = 'Events/lighting.dmi'

	var tmp
		tile_light = 0
		lights[0]
		last_updated

	proc
		// update the light level of the lighting object
		update() if(event_lighting && last_updated != world.time)

			#ifndef LIGHTING
			return
			#endif

			last_updated = world.time

			var global_light = event_lighting.global_light	// light level of the world
			var result = tile_light							// resultant light level

			result = 0
			for(var/o in lights)
				result += lights[o]

			#if SHADOWCAST
			var light		// light is the light level of the light source being referenced
			var distance	// distance of light to src

			spawn for(var/atom/l in lights)	// loop through the light sources affecting the lighting object
				light = lights[l]
				for(var/turf/o in getline(loc, l))

					// IF TURFS EVER END UP CASTING SHADOWS, ADD LOGIC HERE

					for(var/atom/movable/a in o)
						if(a == l || a.opacity) continue

						if(a.shadowcast)
							distance = distance(loc, a)
							if(!distance(a, l))
								if(a.shadowcast == 2)
									result -= light
								else continue
							else if(distance && distance <= pi)
								result -= (( (light) / (distance * distance(loc, l)) ) * pi)
			#endif

			result = kMath.clamp(round(result), z == 2 ? 0 : global_light, 230)

			icon_state = "[result]"

atom
	var
		incandescence	// how far the atom casts light

		#if SHADOWCAST
		shadowcast		// 1 if the atom is to cast a shadow (blocks light) 0 if not 2 to block sources when on their tile
		#endif

	proc
		set_incan(n=0) if(event_lighting)

			#ifndef LIGHTING
			return
			#endif

			var old_incan = incandescence
			incandescence = (n>10) ? 10 : (n || 0)
			light( (old_incan > incandescence) ? old_incan : incandescence)

		light(radius) if(event_lighting)

			#ifndef LIGHTING
			return
			#endif


			radius = radius || incandescence
			if(!radius) return

			var distance
			var light_obj/l

			var range[] = range(radius + 5, src)
			var view[]  = view (radius + 3, src)

			var p[] = pos()

			for(var/turf/t in range)
				l = t.get_light_obj()
				if(!t.pos) t.pos = t.pos()

				distance = pos2_dist(p, t.pos)/32

				if(distance < radius + 0.5)
					if((distance >= radius || !(t in view)) && (src in l.lights))
						l.tile_light -= l.lights[src]
						l.lights -= src
					if(l.lights[src])
						l.tile_light -= l.lights[src]

					l.lights[src] = cos(90 * distance / radius) * 230
				//	l.lights[src] = 230 * ( 1/(distance||1) - 1/(radius||1) )
					l.tile_light += l.lights[src]

				l.update()

atom/movable

	New()
		..()

		#ifndef LIGHTING
		return
		#endif

		if(event_lighting)
			if(ismob(src) && src:client) src:client.client_light()
			if(incandescence && event_lighting) light()

	Del()

		#ifndef LIGHTING
		return
		#endif

		if(event_lighting && incandescence)
			set_incan(0)
		..()


	Move()
		. = ..()

		#ifndef LIGHTING
		return
		#endif

		if(. && event_lighting && incandescence)
			if(!ismob(src)) light()

	proc
		illuminate()

			#ifndef LIGHTING
			return
			#endif
			if(event_lighting)
				var view = view(src)
				for(var/atom/a in view)
					if(a.incandescence)
						a.light()
client
	proc
		client_light()

			#ifndef LIGHTING
			return
			#endif

			if(event_lighting && mob.loc)

				var range[] = range(view+2, src)

				for(var/turf/Environment/Cave/Caves/cave in range)
					cave.incandescence = round(event_lighting.global_light/50)
					cave.light()

				for(var/turf/t in range)
					t.get_light_obj()
					t.light_obj.update()

mob
	move()
		. = ..()

		#ifndef LIGHTING
		return
		#endif

		if(. && event_lighting)
			if(client) client.client_light()
			if(incandescence) light()

#if SHADOWCAST
//-----------------------------------
//	SHADOWCASTING ATOMS
//-----------------------------------

mob
	shadowcast = 1
	Corpse/shadowcast = 0
	Animal
		Ramar/shadowcast = 0
		Peek/shadowcast = 0
		Kaw/shadowcast = 0
obj
	Mining/Deposits/shadowcast = 1
	Woodcutting
		shadowcast = 1
		Bush/shadowcast = 0
		Dead/Bush/shadowcast = 0
		Desert/shadowcast = 0
	Built
		shadowcast = 0
		Pillar/shadowcast = 1
		Support_Beam/shadowcast = 1
		Bookshelf/shadowcast = 1
		Forge/shadowcast = 1
#endif

//----------------------------------
//	INCANDESCENT ATOMS
//----------------------------------


obj/Fire/incandescence = 2

turf/Environment
	Lava/incandescence = 1

	Cave/Enter(mob/m)
		. = ..()
		if(. && m.incandescence) light(m.incandescence)

	Cliffs/Enter(mob/m)
		. = ..()
		if(. && m.incandescence) light(m.incandescence)

obj/Item/Tools/Torch
	New()
		..()
		spawn(1)
			if(icon == 'Tools/torch_wall.dmi' && incandescence)
				icon_state = "lit"