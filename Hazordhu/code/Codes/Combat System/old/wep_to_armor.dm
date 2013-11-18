mob
	proc/bonus_check(mob/humanoid/target, dmg)
		if(!is_humanoid(target))
			return dmg

		var obj/hit_loc = target.equipment[pick("helmet", "body", "legs", "hands", "feet")]
		if(!hit_loc) return dmg

		var hl_bonus, hl_neg

		if(hit_loc.Type)
			switch(hit_loc.Type)
				if("Plate")
					hl_bonus	=	"Bash"
					hl_neg		=	"Pierce"
				if("Chain")
					hl_bonus	=	"Pierce"
					hl_neg		=	"Slash"
				if("Leather")
					hl_bonus	=	"Slash"
					hl_neg		=	"Bash"

		if(is_humanoid(src))
			var mob/humanoid/h = src
			var obj/weapon = h.is_weapon_equipped()
			if(weapon)
				if(weapon.Type == hl_bonus)
					dmg = round(dmg * 0.4)
					if(prob(30)) dmg = 0
				else if(weapon.Type == hl_neg)
					dmg = round(dmg * 1.4)
		return dmg