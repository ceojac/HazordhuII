
mob/player
	var
		tmp/sound
			riversound
			waterfallsound
			forestsound
			firesound
			footstep

			winterbg

	move_tick()
		..()
		checkSound()

	proc/checkSound()
		var range = range(src)

		//	Forest ambience, AKA annoying chirping emanating from trees
		if(0)
			var obj/Woodcutting/tree
			for(tree in range) if(tree.name == "Tree") break
			if(tree)
				var dist = get_dist(src, tree)
				var vol = 25 - dist / world.view * 25
				if(!forestsound) forestsound = sound(file='code/Sounds/forestbg.wav',repeat=1,wait=0,channel=2,volume=vol)
				forestsound.volume = vol
				forestsound.status = SOUND_STREAM | SOUND_UPDATE
				src << forestsound
			else if(forestsound) src << sound(channel=2)

		//	Water ambience
		if(1)
			var turf/Environment/water
			for(water in range)
				if(water.icon == 'code/Turfs/Water.dmi' && water.icon_state != "Fall" || water.icon == 'code/Turfs/ocean.dmi')
					if(water.icon_state == "river")
						break

			var turf/Environment/waterfall
			for(waterfall in range)
				if(waterfall.icon == 'code/Turfs/Water.dmi' && waterfall.icon_state == "Fall")
					break

			var dist, vol

			if(waterfall)
				dist = bounds_dist(src, waterfall) / 32
				vol = (50 - dist / world.view * 50) / 4
				if(!waterfallsound)
					waterfallsound = sound(file='code/Sounds/waterfall.wav', repeat=1, wait=0, channel=4, volume=vol)
				waterfallsound.volume = vol
				waterfallsound.status = SOUND_STREAM | SOUND_UPDATE
				src << waterfallsound
			else if(waterfallsound)
				src << sound(channel=4)

			if(water)
				dist = bounds_dist(src, water) / 32
				vol = (50 - dist / world.view * 50) / 2
				if(!riversound)
					riversound = sound(file='code/Sounds/brook2.wav', repeat=1, wait=0, channel=3, volume=vol)
				riversound.volume = vol
				riversound.status = SOUND_STREAM | SOUND_UPDATE
				src << riversound
			else if(riversound)
				src << sound(channel=3)