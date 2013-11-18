mob
	proc
		joust(mob/hit, mob/Animal/hit_mount)
			if(!jousting_tournament)
				var/damage = rand(10,25)
				hit.Health -= damage
				display_damage(hit, damage)
			if(prob(40))
				for(var/mob/M in hearers(hit)) M << "*[hit.textIcon()]<b>[M.nameShown(hit)]</b> has been knocked from their [hit_mount]!*"
				hit.Mount = null
				hit_mount.rider = null
				hit.pixel_y=0
				hit.Locked =1
				spawn(25) hit.Locked =0
				step_rand(hit_mount)
				hit_mount.layer = initial(hit_mount.layer)
//			if(hit.Health > 0 && prob(30))
//				hit << "You have been knocked unconcious!"
//				src << "You have knocked [hit.name] unconcious!"
//				hit.KO = 1
//				hit.sight |= BLIND
//				spawn(1) hit.WakeUp()
			hit.DeathCheck(src, "jousting")
			hit_mount.DeathCheck(src, "jousting")