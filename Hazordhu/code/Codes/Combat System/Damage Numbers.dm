
var const/damage_icon = 'code/Codes/Combat System/Damage Numbers.dmi'
var damage_icon_cache[0]

proc/display_damage(atom/a, n, color="#FF0000")
	n = round(n, 1)
	if(!("[n]-[color]" in damage_icon_cache))
		var icon/result
		if(n >= 1000)	result = icon(damage_icon, "+999")	//	the limit is 999
		else if(n < 10)	result = icon(damage_icon, "[n]")	//	single digits need no special treatment
		else if(n < 1000)
			var text = "[n]", length = length(text)
			var digits[0]

			var start = 1
			while(start <= length) digits.Insert(1, copytext(text, start, ++start))

			result = icon(damage_icon, digits[1])
			digits.Cut(1, 2)

			var pos
			for(var/digit in digits)
				var icon/i2 = icon(damage_icon, digit)
				i2.Shift(WEST, ++pos * 6)
				result.Blend(i2, ICON_OVERLAY)
		result.Blend(color, ICON_ADD)
		damage_icon_cache["[n]-[color]"] = fcopy_rsc(result)

	var obj/damage_num/damage_num = new (locate(a.x, a.y, a.z))

#if PIXEL_MOVEMENT
	if(istype(a, /atom/movable))
		var atom/movable/m = a
		damage_num.pixel_x = m.step_x + m.bound_x
		damage_num.pixel_y = m.step_y + m.bound_y
#endif

	flick(damage_icon_cache["[n]-[color]"], damage_num)
	spawn(10) damage_num.set_loc()

obj/damage_num
	icon = null
	mouse_opacity = 0
	layer = 99