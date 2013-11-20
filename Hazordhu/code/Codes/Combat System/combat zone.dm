
mob
	var tmp
		image/combat_zone_indicator
		combat_zone[]

	proc
		combat_zone()
			if(client)
				if(!combat_zone)
					update_combat_zone()
				return combat_zone

		update_combat_zone()
			if(!client) return

			client.images -= combat_zone_indicator
			combat_zone = null

			if(!combat_mode) return

			if(!client.mouse.over)
				client.mouse.angle = dir2angle(dir)
			var angle = client.mouse.angle
			var dx = sin(angle) * 16
			var dy = cos(angle) * 14 + 2

			if(!combat_zone_indicator) combat_zone_indicator = image('code/codes/combat system/attack zone.dmi', loc=src, layer=100)

			var image/i = combat_zone_indicator

			i.pixel_x = dx
			i.pixel_y = dy

			if(combat_mode) client.images += i

			combat_zone = obounds(src, dx - 2, dy - 4, -bound_width + 16, -bound_height + 10)
