obj/Item
	var health
	var max_health

	proc/set_max_health(n)
		max_health = n
		health = n

	proc/take_damage()
	proc/update_damage_icon()

mob
	proc/used_tool(obj/Item/Tools/tool = equipment["main"])
		if(ispath(tool))
			tool = locate(tool) in Equipment()
		if(!tool) return
		tool.take_damage()

	proc/used_weapon(obj/Item/Weapons/weapon = equipment["main"])
		used_tool(weapon)

	proc/used_shield(obj/Item/Weapons/shield = equipment["off"])
		used_tool(shield)

#if ITEM_DURABILITY

obj/Item
	Read(savefile/s)
		..()
		if(health)
			update_damage_icon()
		else if(!icon)
			icon = initial(icon)

	take_damage(damage = 1)
		if(isnull(health))
			if(max_health)
				health = max_health
			else return

		var pre_health_percent = health / max_health

		health = clamp(health - damage, 0, max_health)

		var health_percent = health / max_health

		if(pre_health_percent > 0.25 && health_percent <= 0.25)
			var mob/humanoid/m = loc
			if(istype(m)) m.aux_output("<b><i>Your [src] is getting damaged.")

		if(pre_health_percent > 0.05 && health_percent <= 0.05)
			var mob/humanoid/m = loc
			if(istype(m)) m.aux_output("<b><i>Your [src] is about to break!")

		if(!health)
			var mob/humanoid/m = loc
			if(istype(m))
				m.unequip(src)
				m.aux_output("<b><i>Your [src] is worn out and falls apart.")
			del src

		update_damage_icon()

	update_damage_icon()
		if(isnull(max_health)) return
		var percent = health / max_health
		var stage = 3 + round(-percent * 3, 1)
		var icon/base = icon(initial(icon), "item")
		if(stage)
			var icon/mask = icon('code/Icons/decay.dmi', "stage[stage]")
			mask.Blend(base, ICON_SUBTRACT)
			base.Blend(mask, ICON_OVERLAY)
		var icon/i = icon(initial(icon))
		i.Insert(base, "item")
		icon = fcopy_rsc(i)

	Tools
		max_health = 120

	Weapons
		max_health = 150
#endif