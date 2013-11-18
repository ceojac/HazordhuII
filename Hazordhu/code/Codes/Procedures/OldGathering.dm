
mob
	proc/Mine(obj/Mining/Deposits/O)
		if(Locked) return
		if(mount)
			aux_output("You can't mine while mounted.")
			return

		var mob/player/player = is_player(src) && src
		if(player && O.level_requirement > player.skill_level(MINING))
			aux_output("Your mining skill isn't sufficient to mine [O]!")
			return

		if(!use_stamina(2, "mine")) return

		used_tool()

		var obj/gath_olay/olay = new
		olay.icon = 'code/Icons/GatheringOverlays/Mining.dmi'
		olay.layer = O.layer + 1
		O.overlays += olay

		var sound/s = sound(pick('code/Sounds/smith1.wav', 'code/Sounds/smith2.wav'))
		s.volume = rand(50, 100)
		s.frequency = 1 + randn(-0.1, 0.1)
		for(var/mob/h in hearers(src))
			s.volume = (8 - get_dist(src, h)) * 10
			s.status = SOUND_UPDATE
			h.hear_sound(s)

		icon_state = "swing"
		_do_work(10)
		icon_state = ""

		var strikes = 1
		if(player && player.GodMode) strikes = O.resources
		for(var/strike in 1 to strikes) if(O)
			O.overlays -= olay

			. = new O.resource
			var ores[] = list(.)
			var obj/Item/ore = .

			if(player)
				var skill_level/mining/mining = player.get_skill(MINING)
				player.gain_experience(mining, O.experience)
				ores += mining.mine_bonus(O.resource)

				var global/mines[] = list("Clay", "Hazium", "Metal", "Stone", "Sandstone")
				if(!player.hasMined) player.hasMined = new
				if(!player.hasMined[ore.name])
					//	Mining something for the first time gives bonus exp
					player.gain_experience(MINING, O.experience * 10)
				player.hasMined[ore.name] ++
				if(player.hasMined.len >= mines.len)
					medalMsg("Miner")

			for(var/obj/Item/i in ores)
				i.Move(loc, 0, step_x, step_y)

			if(!O.infinite)
				O.resources -= ores.len
				if(O.resources <= 0)
					var obj/Mining/cave_walls/cave = O
					if(!istype(cave))
						O.set_loc()
					else
						cave.deplete()
		del olay


	proc/Chop(obj/Woodcutting/O)
		if(Locked) return
		if(mount)
			aux_output("You can't chop wood while riding something.")
			return

		if(!use_stamina(2, "chop wood")) return

		used_tool()

		var obj/gath_olay/olay = new
		olay.icon = 'code/Icons/GatheringOverlays/Woodcutting.dmi'
		olay.pixel_x = 32
		if(istype(O, /obj/Woodcutting/Jungle)) olay.pixel_x = 32
		if(O.name == "Bush" || O.name == "Cactus" || O.name == "Thin Tree") olay.pixel_x = 0
		olay.layer = O.layer + 1
		O.overlays += olay

		var sound/s = sound('code/Sounds/knock_knock.wav')
		s.volume = rand(50, 100)
		s.frequency = 1 + randn(-0.1, 0.1)
		for(var/mob/h in hearers(src))
			s.volume = (world.view - get_dist(src, h)) * 10
			s.status = SOUND_UPDATE
			h.hear_sound(s)

		icon_state = "swing"
		_do_work(10)
		icon_state = ""

		if(O)

			O.overlays -= olay

			. = new /obj/Item/Wood/Log
			var woods[] = list(.)

			var mob/player/player = is_player(src) && src
			if(player)
				var skill_level/woodcutting/woodcutting = player.get_skill(WOODCUTTING)
				player.gain_experience(woodcutting, O.experience)
				woods += woodcutting.log_bonus()

			for(var/obj/Item/i in woods)
				i.Move(loc, 0, step_x, step_y)

			if(!O.infinite)
				O.resources -= woods.len
				if(O.resources <= 0)
					medalMsg("Lumberjack")
					del O
		del olay