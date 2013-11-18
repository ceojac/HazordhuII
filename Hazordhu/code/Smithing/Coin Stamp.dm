
obj/Item
	Tools/Coin_Stamp
		icon = 'code/tools/coin stamp.dmi'

		var group_id
		var group_name

		/savedatum
			var group_id
			var group_name

		save_to(savedatum/s)
			..()
			if(group_id)
				s.group_id = group_id
				s.group_name = group_name

		load_from(savedatum/s)
			..()
			if(s.group_id)
				group_id = s.group_id
				group_name = s.group_name

		proc/stamp(mob/player/m, obj/Item/Metal/Coins/coin)
			if(coin.stamp_id)
				coin.stamp_id = null
				m.aux_output("You clear the stamp on the coin.")
				coin.name = initial(coin.name)
				coin.Stack_Check()

			else
				coin.stamp_id = group_id
				m.aux_output("You stamp the coins with your group's unique identification.")
				coin.name = "[initial(coin.name)] \[[group_name]]"
				coin.Stack_Check()

	Metal
		Coins
			var stamp_id

			use(mob/humanoid/m) if(loc == m)
				var obj/Item/Tools/Coin_Stamp/stamp = m.get_equipped(/obj/Item/Tools/Coin_Stamp)
				stamp && stamp.stamp(m, src)

			split_as(obj/Item/Metal/Coins/coin)
				coin.stamp_id = stamp_id
				coin.name = name
				return ..()

		Metal_Coins/parent_type = /obj/Item/Metal/Coins