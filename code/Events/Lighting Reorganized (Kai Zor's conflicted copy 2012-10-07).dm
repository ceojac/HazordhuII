
#define LIGHTING 0

//	Definitions
var event/lighting/event_lighting

event
	lighting
		var
			time
			global_light

		proc
			update_daylight()
			time2light()

turf
	var
		tmp
			light_obj/light_obj

	proc
		light_obj()
		update()

light_obj
	parent_type = /obj
	var
		light_sources[]

	proc
		result()
		update()

atom
	var
		incandescence

		tmp
			effected[]

	proc
		clear_light_effect()
		remove_light_effect(light_obj/o)
		add_light_effect(light_obj/o)
		light()
		set_incan(incan)
		illuminate()
		calc_light(light_obj/o)

client
	proc
		client_light()


#if LIGHTING
#warning - Lighting is on!
//	Working code
world/New()
	event_lighting = new
	..()

event
	lighting
		global_light = 0
		time = 0

		New() start_ticking()

		tick()
			time ++

			if(!(time % SECOND))
				update_daylight()


		update_daylight()
			var pre_light = global_light
			global_light = time2light()

			if(pre_light != global_light)
				for(var/client/c)
					c.client_light()

		time2light()
			var hour = world.timeofday/36000+TIME_ZONE
			var p = 15
			. = (1-cos(hour*p))/2


turf
	light_obj()
		if(!light_obj)
			light_obj = new (src)
		return light_obj

	update()
		if(!light_obj)
			light_obj()

		light_obj.update()


light_obj
	icon = 'Events/lighting.dmi'

	layer = 102 + EFFECTS_LAYER
	mouse_opacity = 0

	New()
		..()
		pos = pos()
		light_sources = new

	result()
		. = 0

		if(z != 2)
			. += event_lighting.global_light

		if(light_sources)
			for(var/atom/o in light_sources)
				. += light_sources[o]

	update()
		icon_state = "[round(kMath_clamp(230 * result(), 0, 230))]"

atom
	New()
		..()
		if(incandescence) spawn(5) light()

	clear_light_effect() if(effected)
		for(var/light_obj/o in effected)
			remove_light_effect(o)

	remove_light_effect(light_obj/o)
		o.light_sources	-=	src
		if(effected.len	==	1)
			effected	=	null
		else effected	-=	o
		o.update()

	add_light_effect(light_obj/o)
		if(!effected) effected	=	new

		var new_effect = !(o in effected)

		effected[o]				=	calc_light(o)
		o.light_sources[src]	=	effected[o]

		if(new_effect) o.update()

	light() if(incandescence)
		var view[] = view(incandescence, src)
		for(var/turf/t in view)
			add_light_effect(t.light_obj())

	set_incan(incan)
		if(incandescence && !incan)
			clear_light_effect()

		incandescence = incan

		light()

	illuminate()
		var range[] = range(src)
		for(var/atom/o in range(src))
			if(o.incandescence)
				o.light()

		for(var/mob/m in range)
			if(m.client) m.client.client_light()

	calc_light(light_obj/o)
		if(incandescence)
			if(!pos)	pos		=	pos()
			if(!o.pos)	o.pos	=	o.pos()

			var d = pos2_dist(pos, o.pos) / 32

			if(d > incandescence) return

			. = cos(90 * d / incandescence)

client
	client_light()
		for(var/turf/t in view(view+1, mob.loc))
			t.update()

atom/movable/move()
	. = ..()
	if(.)
		light()
		if(ismob(src))
			var mob/m = src
			if(m.client)
				m.client.client_light()

#endif