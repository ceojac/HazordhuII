obj/Item
	var tmp/can_color
	var Color

	use_alt(mob/humanoid/m)
		if(can_color && !m.is_equipped(src))
			set_color(m)
		else ..()

	proc/set_color(mob/m)
		Color = (input(m, "Choose the color of the [src].", "Color", Color) as null|color) || Color
		apply_color()

	proc/apply_color()
		icon = initial(icon)
		if(Color) icon += Color