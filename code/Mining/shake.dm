var looper/screen_shake_loop = new ("shake tick")

client
	var shake_until
	proc/shake_tick()
		if(world.time >= shake_until)
			pixel_x = 0
			pixel_y = 0
			screen_shake_loop.remove(src)
		else
			pixel_x = rand(-3, 3)
			pixel_y = rand(-3, 3)

	proc/shake(shake_time)
		shake_until = world.time + shake_time
		screen_shake_loop.add(src)