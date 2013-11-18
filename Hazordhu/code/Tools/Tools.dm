
obj
	Item
		var overlayo
		Tools
			var
				Sharpness = 0
				Damage = 0
				Defense
				aType

			Damage = 1
			Stackable = 0
			aType = "swing"
			value = 10

			Hoe
				icon = 'code/Tools/Hoe.dmi'
				value = 4
			Knife
				icon = 'code/Tools/Knife.dmi'
				value = 4
			Quill
				icon = 'code/Tools/Quill.dmi'
				value = 4
			Pickaxe
				icon = 'code/Tools/Pickaxe.dmi'
				value = 4
			NeedleThread
				name = "Needle and Spool"
				icon = 'code/Tools/Needle&Thread.dmi'
				value = 3
			Hatchet
				icon = 'code/Tools/Hatchet.dmi'
				value = 4
			Hammer
				icon = 'code/Tools/Hammer.dmi'
				value = 4
			Tongs
				icon = 'code/Tools/Tongs.dmi'
				value = 4
			Chisel
				icon = 'code/Tools/Chisel.dmi'
				value = 4
			Carding_Tool
				icon = 'code/Tools/Carding Tool.dmi'
				value = 4
			Trowel
				icon = 'code/Tools/Straight Edge.dmi'
				value = 4
			Shovel
				icon = 'code/Tools/Shovel.dmi'
				value = 4
			Brush
				icon = 'code/Tools/Brush.dmi'
				value = 3
			Pan
				icon = 'code/Tools/Pan.dmi'
				value = 4
			Spoon
				icon = 'code/Tools/Spoon.dmi'
				value = 4
			Staff
				icon = 'code/Tools/Staff.dmi'
				value = 4

			Scissors
				icon = 'code/Tools/Scissors.dmi'
				value = 4
				use(mob/player/p) if(loc == p)
					var hairs[0]
					var default
					for(var/hair_type in typesof(/obj/Hair) - /obj/Hair)
						var obj/Hair/hair = new hair_type
						if(istype(p.Hair, hair_type))
							default = hair
						hairs += hair
					var selected = input(p, "Which hairstyle do you want?", "Hair Style", default) as null|anything in hairs
					if(!selected) return
					p.Remhair()
					p.Hair = selected
					p.Gethair()

			Fishing_Rod
				icon = 'code/Tools/Fishing Rod.dmi'
				value = 4


			Torch
				icon = 'code/Tools/Torch.dmi'
				value = 6

				New()
					..()
					spawn(5)
						if(icon_state == "lit")
							set_light(5)
						else set_light(0)

				var placed_dir

				grabbed_by()
					set_light(0)
					remove_wall()
					..()

				proc/remove_wall()
					layer = initial(layer)
					icon = 'code/Tools/torch.dmi'
					icon_state = "item"
					pixel_x = 0
					pixel_y = 0
					placed_dir = 0

				interact_right()
					if(icon == 'code/Tools/torch_wall.dmi')
						switch(icon_state)
							if("lit")
								icon_state = "item"
								set_light(0)
							else
								icon_state = "lit"
								set_light(5)

				MouseDrop(atom/object)
					..()
					var mob/player/player = usr
					if(loc == player && !player.is_equipped(src) && (object in oview(1, player)))
						var is_wall =  object.type in list( /obj/Built/Wall,
															/obj/Built/Stone_Wall,
															/obj/Built/Sandstone_Wall,
															/obj/Built/Brick_Wall,
															/obj/Built/Log_Wall,
															/obj/Built/Tower,
															/obj/Built/Pallisade_Wall,
															/obj/Built/Orc_Pallisade_Wall,
															/obj/Built/Barred_Wall)
						if(!is_wall) return
						Drop(player)

						var _dir = get_dir(player, object)
						switch(_dir)
							if(1) pixel_y += 32
							if(2) pixel_y -= 16
							if(4) pixel_x += 16
							if(8) pixel_x -= 16
							else return

						set_loc(player.loc)

						layer = object.layer + 1
						icon = 'code/Tools/torch_wall.dmi'
						icon_state = "lit"

						dir = _dir
						placed_dir = _dir

						set_light(5)

obj/Built/Del()
	if(loc)
		//	Check for torches
		for(var/obj/Item/Tools/Torch/t in orange(1, loc))
			if(get_dir(t, src) == t.placed_dir)
				t.remove_wall()
	..()