
obj
	Item
		Ball
			SET_TBOUNDS("9,9 to 24,24")
			icon = 'code/Icons/ball.dmi'
			density = true
			SET_STEP_SIZE(6)

			Drop()
				density = false
				return ..()

			split_as(obj/Item/item)
				item.density = false
				return ..()

			dropped_by(m)
				Stackable = false
				density = true
				return ..()

			grabbed_by(m)
				Stackable = true
				density = false
				vel = null
				move_loop.remove(src)
				return ..()

			var tmp/mob/kicker

			var vel[]
			var decel[]

			Bumped(mob/m)
				if(istype(m))
					dir = m.dir
					kicker = m

					vel = vec2_setmag(vec2_to(m.center(), center()), vec2_mag(dir2offset(m.dir)) * m.step_size * 3)
					decel = vec2_setmag(vec2_neg(vel), 1)
					move_loop.add(src)
				..()

			proc/move_tick()
				var moved = move(vel)

				if(vel[1])
					if(!(moved & HORI))
						vel[1] *= -1
						decel[1] *= -1
						reset_pos()
					if(vel[1] > 0)
						vel[1] = max(0, vel[1] + decel[1])
					else vel[1] = min(0, vel[1] + decel[1])

				if(vel[2])
					if(!(moved & VERT))
						vel[2] *= -1
						decel[2] *= -1
						reset_pos()
					if(vel[2] > 0)
						vel[2] = max(0, vel[2] + decel[2])
					else vel[2] = min(0, vel[2] + decel[2])

				var speed = vec2_mag(vel)
				if(speed > 16) vel = vec2_setmag(vel, 16)

				if(vec2_iszero(vel)) move_loop.remove(src)