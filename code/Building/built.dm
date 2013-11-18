obj/Built
	var base_health

	New()
		..()
		set_max_health(base_health * 50)

	proc/set_max_health(h)
		MaxHealth = h
		Health = h

	proc/gain_max_health(h)
		MaxHealth += h

	proc/gain_health(h)
		Health = min(Health + h, MaxHealth)

	proc/take_damage(damage, cause)
		display_damage(src, damage)
		Health = max(Health - damage, 0)
		attacked_by(cause)

	proc/attacked_by(mob/mortal/m)
		if(!Health) destroyed_by(m)

	proc/destroyed_by(mob/mortal/m)
		if(m.client)
			var mob/player/p = m
			AdminsOnline << "<font color=red>[p.key] ([p.charID]) destroyed [name] [ADMIN_TELE(p)]"
			p.log_action("destroyed [name]")
			del src

	Combat_Dummy/take_damage(damage, cause) return ..(1, cause)