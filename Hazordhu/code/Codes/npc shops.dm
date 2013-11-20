mob
	NPC
		shopkeep
			Health=45000
			MaxHealth=45000
			orc
				New()
					..()
					icon = pick(list(
					'Mobs/Orc/m_stonehammer.dmi','Mobs/Orc/m_warcry.dmi','Mobs/Orc/m_windhowl.dmi',
					'Mobs/Orc/f_stonehammer.dmi','Mobs/Orc/f_warcry.dmi','Mobs/Orc/f_windhowl.dmi'))

			icon = 'Mobs/Human/m_tan.dmi'
			icon_state = "White"


			var
				tmp
					in_use	//determines if the shop keeper is being used
					obj
						usr_barter
						shop_barter


			DblClick() if(src in oview(2))
				if(in_use)
					usr << "Sorry, I'm busy."
					return

				usr_barter = new
				shop_barter = new

				in_use = usr
				usr.shop = src
				usr.client.PositionWindow("shopkeep",208,151)
				winshow(usr,"shopkeep",1)
				usr.update_shop(src)


			New()
				..()
				icon = pick(list(
					'Mobs/Human/m_black.dmi','Mobs/Human/m_tan.dmi','Mobs/Human/m_pale.dmi','Mobs/Human/m_white.dmi',
					'Mobs/Human/f_black.dmi','Mobs/Human/f_tan.dmi','Mobs/Human/f_pale.dmi','Mobs/Human/f_white.dmi'))

				var/obj
					shirt_overlay = pick(typesof(/obj/Item/Clothing/Shirt)-list(/obj/Item/Clothing/Shirt,/obj/Item/Clothing/Shirt/Flargl_Leather_Shirt))
					pant_overlay = pick(typesof(/obj/Item/Clothing/Pants)-list(/obj/Item/Clothing/Pants,/obj/Item/Clothing/Pants/Flargl_Leather_Pants))
					hair_overlay = pick(typesof(/obj/Hair)-/obj/Hair-/obj/Hair/None)
				hair_overlay = new hair_overlay
				hair_overlay.layer = MOB_LAYER+1
				hair_overlay.dir = dir
				shirt_overlay = new shirt_overlay
				shirt_overlay.dir = dir
				pant_overlay = new pant_overlay
				pant_overlay.dir = dir
				overlays += shirt_overlay
				overlays += pant_overlay
				overlays += hair_overlay

				contents += newlist(
					/obj/Item/Weapons/Sword,
					/obj/Item/Weapons/Spear,
					/obj/Item/Weapons/Axe,
					/obj/Item/Weapons/Shield)

mob
	var/tmp/mob/NPC/shopkeep/shop
	proc
		update_shop() if(shop)
			var/i = 0
			for(var/obj/Item/o in shop)
				if(o.type == /obj/Item/Metal/Metal_Coins) continue
				src << output(o,"shopkeep.shop_grid:[++i]")
			winset(src,"shopkeep.shop_grid", "cells=[i]")

			i = 0
			for(var/obj/Item/o in shop.usr_barter)
				src << output(o,"shopkeep.you_barter:1,[++i]")
				src << output(o.value * o.Stacked,"shopkeep.you_barter:2,[i]")
			winset(src,"shopkeep.you_barter", "cells=2x[i]")

			i = 0
			for(var/obj/Item/o in shop.shop_barter)
				src << output(o,"shopkeep.shop_barter:1,[++i]")
				src << output(o.value * o.Stacked,"shopkeep.shop_barter:2,[i]")
			winset(src,"shopkeep.shop_barter", "cells=2x[i]")

	verb
		stop_shop(n as num) if(shop)
			set hidden = 1
			var/obj/Item/i
			if(!n)
				for(i in shop.usr_barter)  i.Move(src)
				for(i in shop.shop_barter) i.Move(shop)
			else
				var/usr_val
				var/shop_val
				for(i in shop.usr_barter)  usr_val  += i.value * i.Stacked
				for(i in shop.shop_barter) shop_val += i.value * i.Stacked
				if(usr_val >= shop_val)
					for(i in shop.usr_barter)  i.Move(shop)
					for(i in shop.shop_barter) i.Move(src)
					if(usr_val > shop_val)
						//	There's a way to make this smaller. Can't figure it out at the moment and it doesn't really matter.
						var/diff = usr_val - shop_val
						var/coin = /obj/Item/Metal/Metal_Coins

						i = locate(coin)in shop
						if(i)
							if(i.Stacked > diff)
								i.Stack_Check(diff)
								i = new coin
								i.Stacked = diff
							if(i.Stacked < diff)
								var/is = i.Stacked
								i.Move(src)
								i = new coin
								i.Stacked = diff - is
						else
							i = new coin
							i.Stacked = diff
						i.Move(src)

				else
					s_alert("I'm sorry, but that isn't a fair trade...","Shopkeep","Okay")
					return

			winshow(src,"shopkeep",0)
			update_shop()
			shop.in_use = null
			shop = null

//	This is in case the shopkeeper might possibly still think you're there after you log out.
	Logout()
		if(shop) stop_shop(0)
		..()

obj/Item/MouseDrop(over_object,src_location,over_location,src_control,over_control,params)
	..()
	if(usr.shop)
		var/list/p = params2list(params)
		var/obj/Item/i
		switch("[src_control]>[over_control]")
			if("inventory.inventorygrid>shopkeep.you_barter")	//	from inventory to usr_barter
				if(!Stackable || Stacked == 1) Move(usr.shop.usr_barter)
				else if("ctrl" in p)
					if(Stacked <= 15) Move(usr.shop.usr_barter)
					else
						Stack_Check(15)
						i = new type
						i.Stacked = 15
					//	i.Stack_Check()	//	I think item.Move() calls Stack_Check() automatically?
						i.Move(usr.shop.usr_barter)
				else
					Stack_Check(1)
					new type(usr.shop.usr_barter)
				usr.InventoryGrid()

			if("shopkeep.shop_grid>shopkeep.shop_barter")		//	from shop's contents to shop_barter
				if(!Stackable || Stacked == 1) Move(usr.shop.shop_barter)
				else if("ctrl" in p)
					if(Stacked <= 15) Move(usr.shop.shop_barter)
					else
						Stack_Check(15)
						i = new type
						i.Stacked = 15
					//	i.Stack_Check()
						i.Move(usr.shop.shop_barter)
				else
					Stack_Check(1)
					new type(usr.shop.shop_barter)

			if("shopkeep.shop_barter>shopkeep.shop_grid")		//	from shop_barter to shop's contents
				if(!Stackable || Stacked == 1) Move(usr.shop)
				else if("ctrl" in p)
					if(Stacked <= 15) Move(usr.shop)
					else
						Stack_Check(15)
						i = new type
						i.Stacked = 15
					//	i.Stack_Check()
						i.Move(usr.shop)
				else
					Stack_Check(1)
					new type(usr.shop)

			if("shopkeep.you_barter>inventory.inventorygrid")		//	from you_barter to your contents
				if(!Stackable || Stacked == 1) Move(usr)
				else if("ctrl" in p)
					if(Stacked <= 15) Move(usr)
					else
						Stack_Check(15)
						i = new type
						i.Stacked = 15
					//	i.Stack_Check()
						i.Move(usr)
				else
					Stack_Check(1)
					new type(usr)
				usr.InventoryGrid()

		usr.update_shop()