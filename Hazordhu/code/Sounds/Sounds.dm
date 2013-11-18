mob
	var sounds_muted = FALSE

	proc/hear_sound(file, repeat, wait, channel, volume)
		if(!client) return
		if(sounds_muted) return
		if(istype(file, /sound)) src << file
		else src << sound(file, repeat, wait, channel, volume)

	proc/view_sound(file, repeat, wait, channel, volume = 100)
		for(var/mob/m in hearers(src))
			if(m.client)
				m.hear_sound(
					file,
					repeat,
					wait,
					channel,
					volume = (1 - bounds_dist(src, m) / world.view / 32) * volume
				)