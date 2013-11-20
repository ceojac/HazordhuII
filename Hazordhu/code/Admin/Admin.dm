
var const/login_message_save = "Data/login message.sav"
proc/save_login_message()
	fdel(login_message_save)
	if(LoginMessage.message_from_admins)
		. = new /savefile (login_message_save)
		. << LoginMessage.message_from_admins

proc/load_login_message()
	if(fexists(login_message_save))
		. = new /savefile (login_message_save)
		. >> LoginMessage.message_from_admins
		LoginMessage.update()

client
	set_keys()
		. = ..()
		keys += "q"

	Click(turf/t, l, c, pa)
		var p[] = params2list(pa)
		var mob/player/player = mob
		if(player.click_create)
			if(p["left"])
				if(isturf(l))
					new player.click_create (l)
			else if(p["right"])
				call(player, "Click Create")()
		else if(player.click_teleport)
			if(p["left"])
				if(isturf(l))
					player.Move(l)
			else if(p["right"])
				call(player, "Click Teleport")()
		else return ..()

	Topic(href, hlist[])
		. = ..()
		if("action" in hlist)
			if(hlist["action"] == "admin_tele")
				if(!Admins.Find(key)) return
				var dx = text2num(hlist["dx"])
				var dy = text2num(hlist["dy"])
				var dz = text2num(hlist["dz"])
				mob.set_loc(locate(dx, dy, dz))

mob
	var GodMode

	player
		var
			tmp
				click_create
				click_teleport

			OOC_Color
			ghost_logged = 0

		proc/apply_ghost_icon()
			icon_reset()
			overlays = new
			var icon/i = flat_icon()
			i.Blend(rgb(0, 0, 0, 150), ICON_ADD)
			icon = i
			reset_flat_icon()

		equip()
			. = ..()
			if(. && GodMode)
				apply_ghost_icon()

		unequip()
			. = ..()
			if(. && GodMode)
				apply_ghost_icon()

		update_equipment_layers()
			..()
			if(GodMode)
				apply_ghost_icon()

		key_down(k)
			if(k == "q") if(key in Admins) call(src, "admin panel")()
			else ..()

		var tmp/devmode = 0
		proc/choosePlayer(message, title, default, container = Players)
			var keys[0]
			for(var/mob/m in Players)
				var name = m.nameShown(m)
				keys["[m.key][name != m.key ? " \"[name]\"" :]"] = m
			var choice = input(src, message, title, default) as null|anything in keys
			return choice && keys[choice]

		proc/LogAction(action)
			StaffLog += action

	Admin
		parent_type = /mob/player

		verb
		#if !PIXEL_MOVEMENT
			Test_Tile_Movement()
				. = list()
				for(var/atom/movable/o)
					#define report(v) {if(!(.[o])).[o]=list();.[o]+="[#v]: [o.v]"}
					if(o.bounds != "32,32")  report(bounds)
					if(o.step_x != 0) report(step_x)
					if(o.step_y != 0) report(step_y)
					if(o.bound_x != 0) report(bound_x)
					if(o.bound_y != 0) report(bound_y)
					if(o.bound_width != 32) report(bound_width)
					if(o.bound_height != 32) report(bound_height)
					#undef do_thing
				if(length(.))
					for(var/atom/movable/o in .)
						src << "<b>[o.type]</b>"
						for(var/t in .[o])
							src << t
				else
					src << "No atoms with changed pixel-movement variables."
		#endif

			Shut_Friggin_Down()
				shutdown()

			player_permissions()
				var mob/player/M = choosePlayer("Which player do you want to set permissions for?", "Player Permissions")
				if(!M) return
				switch(input(
						"[M.key]'s permissions:\n\
						OOC:\t\t[M.can_ooc ? "Enabled" : "Disabled"]\n\
						Combat:\t\t[M.pvp ? "Enabled" : "Disabled"]\n\
						Admin Help:\t[M.can_admin_help ? "Enabled" : "Disabled"]",
						"Player Permissions") as null|anything in list("OOC", "Combat", "Admin Help"))
					if("OOC")
						if(M.key in Admins)
							usr << "You can't do that to an Admin."
							return

						if(!M.can_ooc)
							M.can_ooc = true
							world << "[key] has OOC unmuted [M.key]."
							LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] has OOC unmuted [M.key]<br>")

						else
							M.can_ooc = false
							world << "[key] has OOC muted [M.key]."
							LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] has OOC muted [M.key]<br>")
					if("Combat")
						if(M.key in Admins)
							usr << "You can't do that to an Admin."
							return
						if(!M.pvp)
							M.pvp = true
							AdminsOnline << "[key] has enabled combat for [M] ([M.key])."
							M << "[key] has enabled your combat."
							LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] has disabled combat for [M.key]<br>")
						else
							M.pvp = false
							AdminsOnline << "[key] has disabled combat for [M] ([M.key])."
							M << "[key] has disabled your combat."
							LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] has disabled combat for [M.key]<br>")
					if("Admin Help")
						if(M.key in Admins)
							usr << "You can't do that to an Admin."
							return
						if(!M.can_admin_help)
							M.can_admin_help = true
							AdminsOnline << "[key] has enabled Admin Help for [M] ([M.key])."
							M << "[key] enabled your Admin Help access."
							LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] has enabled admin help for [M.key]<br>")
						else
							M.can_admin_help = false
							for(var/mob/m)
								if(m.key in Admins)
									m << "[key] has disabled Admin Help for [M] ([M.key])."
							M << "[key] has disabled your Admin Help access."
							LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] has disabled admin help for [M.key]<br>")

			view_logs()
				switch(input("Which logs would you like to see?", "View Logs") as null|anything in list("Chat", "Player", "Fire"))
					if("Chat") View_Chat_Logs()
					if("Player") action_log()
					if("Fire") view_fire_log()

			edit_login_message()
				LoginMessage.message_from_admins = input(
					"Set the \"Administrators' Note\" section of the login message to what?", "Login Message",
					LoginMessage.message_from_admins) as message
				LoginMessage.update()
				view_login_message()

			check_animals()
				src << "Active animals: [active_animals.len]"
				var animals[0]
				for(var/mob/Animal/a in active_animals)
					animals[a.name] ++

				for(var/a in animals)
					src << "\t[a]:\t[animals[a]]"

			set_fps()
				var new_fps = input("Set world.fps", "FPS", world.fps) as num
				world.fps = new_fps
				global.fps = new_fps
				world << "world.fps changed to [new_fps] (tick_lag=[world.tick_lag])"

			see_through_walls() sight = 28
			see_through_walls_off() sight = 0

			check_prints()
				var/obj/Item/tocheck = input("Choose an item") in contents
				var/c = 0
				for(var/i in tocheck.fingerprints)
					c++
					src << i
				src << "[c] fingerprints found"

			view_fire_log()
				winset(src, "browser_window","is-visible=true; title=\"Fire Log\"")
				usr << browse("<b>Fire Log</b><hr>[fire_log]")

			repop()
				world << "Repopulating"
				world.Repop()
				world << "Repopulation Complete"
			build_ver()
				usr << build
			shutdown_server()
				world << "<b>[usr.key] is shutting down the server.</b>"
				world.log << "[usr.key] shut down the server."
				world.Del()
			artemis_information()
				usr << "<b>ceres1</b> 96.253.11.125:7231"

			Observe()
				var/selected = choosePlayer("Who do you want to watch?","Observe")
				if(!selected) selected = usr
				client.eye = selected
				client.perspective = EYE_PERSPECTIVE

			Ghostlogout()
				//if(key in Admins) return
				Players -= src
				ghost_logged = true
				for(var/mob/player/m)
					if(m.key in Admins)
						m << "[key] has logged out. (Ghost)"
					m << "<i>[key] has logged out.</i>"

			Ghostlogin()
				//if(key in Admins) return
				Players |= src
				ghost_logged = false
				for(var/mob/player/m)
					if(m.key in Admins)
						m << "[key] has logged in. (Ghost)"
					m << "<i>[key] has logged in.</i>"

			MassDelete()
				var view[] = view(src)
				var valid_types[0]
				for(var/obj/Fire/F in view) valid_types += F
				for(var/obj/Item/I in view) valid_types += I
				for(var/obj/Built/B in view) valid_types += B
				for(var/mob/Corpse/C in view) valid_types += C

				var/obj/selected_type = input("Which items in view do you want to remove? This will remove all stacks of this item within your view.")as null|anything in valid_types
				if(!selected_type) return
				if("No" == alert("Are you absolutely sure you want to remove all [selected_type.name] in view? This cannot be undone!",,"Yes","No"))
					return

				for(var/obj/O in view)
					if(ismob(O.loc))
						continue
					if(O.type == selected_type.type)
						O.set_loc(null)

			OpenGame(n as num)
				world.OpenPort(n)

			DevMode()
				set name = "Developer Mode"
				if(!devmode)
					winset(src, "defaut", "statusbar=true")
					winset(src, "map", "right-click=false")
					devmode = true
				else
					winset(src, "default", "statusbar=false")
					winset(src, "map", "right-click=true")
					devmode = false
				client.show_popup_menus = devmode

			Reload_Settings()
				if(Server_Config)
					Server_Config.LoadConfig()
					src << "Server configuration reloaded, values are as follows:"
					for(var/V in Server_Config.vars)
						src << "[V] = [Server_Config.vars[V]]"

			Announce(T as text)
				world << "<center><b>ANNOUNCEMENT</b><br>From [src.key]<br><br>[T]<hr></center>"

			ContactPlayer()
				var mob/player/M = choosePlayer("Which player do you want to contact?", "Contact Player")
				if(M)
					var message = input("What do you want to send to [M.key]?") as null|text
					if(!message) return
					AdminsOnline << "{MESSAGE TO PLAYER '[M.key]'} [message]"
					M << "{MESSAGE FROM ADMIN} [message]"

			Change_OOC_Color()
				OOC_Color = input("Choose a color for your OOC messages.","OOC Color",OOC_Color)as color

			Toggle_OOC()
				ooc_on = !ooc_on
				world << "OOC is now [!ooc_on? "de":]activated."

			War()
				set hidden = 1
				if(!WarTime)
					WarTime=1
					world <<"<b>Hazordhu has entered a Time of War.  The gods have ended their protection of the world."
				else
					WarTime = 0
					world << "<b>Peace has been restored to Hazordhu.  The gods have begun protecting the world once more."

			GhostForm()
				set category = null

				if(!GodMode)
					src << "Ghost form activated."
					GodMode			=	1
					mouse_opacity	=	0
					see_invisible	=	99
					density			=	0
					apply_ghost_icon()

				else
					src << "Ghost form deactivated."
					GodMode			=	0
					mouse_opacity	=	1
					invisibility	=	0
					see_invisible	=	0
					density			=	1
					icon_reset()

			Toggle_Visibility()
				if(!GodMode) GhostForm()
				if(!invisibility)
					invisibility = 99
					src<<"You are invisible."
				else
					invisibility = 0
					src<<"You are visible."

			Reboot()
				if("Yes" == alert("Are you sure?","Reboot","Yes","No"))
					world << "<b>Reboot!</b>"
					world.Reboot()

			Delete(atom/movable/O)
				set category = null
				if(O in Players)
					return
				else
					LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] deleted [O]<br>")
					del O

			ChangeAnimalMaxPopulation(n as num)
				set desc = "Maximum number of animals in the world."
				if(Population > n)
					for(var/a = Population - n, a, a--)
						del locate(/mob/Animal)
				maxAnimalPop = n
				LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[src] changed animal pop to [n]<br>")

			View_Chat_Logs()
				set desc = "Check logs of chat."
				var global/logs[] = list("IC", "OOC", "Staff", "Altar")
				var t = input(src, "Check logs of chat.", "View Chat Logs") as null|anything in logs
				if(t)
					winshow(src, "browser_window")
					var log
					switch(t)
						if("IC") log = saylog
						if("OOC") log = ooclog
						if("Staff") log = StaffLog
						if("Altar") switch(Race)
							if("Human") log = HumanGodLog
							if("Orc") log = OrcGodLog
							if("Elf") log = ElfGodLog
					if(t != "Altar")
						src << browse("<B>[t] Log</B><HR>[log]")
					else src << browse("<B>[Race] [t] Log</B><HR>[log]")

			Flag_Teleport()
				set category = null
				set desc = "Teleport to any flag in the world."

				var Flags[0]
				for(var/obj/Flag/f in world) Flags += f

				var obj/Flag/O = input("Which flag do you want to teleport to?", "Flag Teleport")as null|anything in Flags
				if(O)
					set_loc(get_step(O, SOUTH))
					dir = SOUTH
					season_update()
					LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] teleported to [O]<br>")

			CountAtoms()
				set category = null
				set desc = "Count all atoms in the world."
				set background = 1
				var
					a=0
					t=0
					o=0
					m=0
					tr=0
					mi=0
					item=0
					animal=0
				for(var/area/N)a++
				for(var/turf/N)t++
				for(var/obj/N)o++
				for(var/mob/N)if(!istype(N,/mob/Animal/))m++
				for(var/mob/Animal/N)animal++
				for(var/obj/Woodcutting/Tree/N)tr++
				for(var/obj/Woodcutting/Tree2/N)tr++
				for(var/obj/Mining/cave_walls/M)mi++
				for(var/obj/Item/i)item++
				src<<"<b>[a]</b> areas,"
				src<<"<b>[t]</b> turfs,"
				src<<"<b>[o]</b> objects,"
				src<<"<b>[m]</b> mobs (excluding animals),"
				src<<"<b>[animal]/[maxAnimalPop]</b> animals,"
				src<<"<b>[tr]</b> trees."
				src<<"<b>[mi]</b> mine walls."
				src<<"<b>[item]</b> items."
				src<<"[a+t+o+m] atoms."
				LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] counted atoms.<br>")

			Mute()
				var mob/player/M = choosePlayer("Who will you mute/unmute?", "Mute")
				if(!M) return

				if(M.key in Admins)
					usr << "You can't mute an admin."
					return

				if(!M.Mute)
					M.Mute = 1
					world << "[key] has muted [M.key]."
					LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] has muted [M.key]<br>")

				else
					M.Mute = 0
					world << "[key] has unmuted [M.key]."
					LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] has unmuted [M.key]<br>")

			Boot()
				var mob/player/M = choosePlayer("Who will you kick out of the world?", "Boot")
				if(!M) return
				if(M.key in Admins)
					usr << "You can't boot an admin."
					return
				world << "[key] has booted [M.key]."
				LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] booted [M.key]<br>")
				M.Logout()

			Teleport()
				var mob/player/M = choosePlayer("Who will you teleport to?", "Teleport")
				if(!M) return
				set_loc(M.loc, M.step_x, M.step_y)
				if(mount) mount.set_loc(loc, step_x, step_y)
				usr << "You teleport to [M.key]."
				LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] teleported to [M.key]<br>")

			Summon()
				var mob/player/M = choosePlayer("Who will you summon to you?", "Summon")
				if(!M) return
				M.set_loc(loc)
				if(M.mount) M.mount.set_loc(M.loc)
				usr << "You summon [M.key]."
				LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] summoned [M.key]<br>")

			admin_panel()
				winshow(src, "admin_panel", "true" != winget(src, "admin_panel", "is-visible"))

			adminchat(t as text)
				set category = null
				set desc = "Privately chat to the administrators."
				AdminsOnline << output("<b>[src.key]</b>: [t]", "adminoutput")
				for(var/mob/m in AdminsOnline)
					winshow(m, "admin_panel")

			Edit(mob/M as obj|mob in world,variable in M.vars-list("GodMode"))
				set desc="Edit the variables in an object or mob."
				var default="File"
				var typeof = M.vars[variable]
				if(ismob(M))
					if((M.key in Admins) && M != src)
						usr<<"You can't edit an admin."
						return

				if(isnull(typeof))
					default = "Text"
				else if(isnum(typeof))
					default = "Num"
				else if(istext(typeof))
					default = "Text"
				else if(isloc(typeof))
					default = "Reference"
				else if(isicon(typeof))
					default = "Icon"
				else if(istype(typeof, /atom) || istype(typeof, /datum))
					default = "Type"
				else if(istype(typeof, /list))
					default = "List"
				else if(istype(typeof, /client))
					default = "Cancel"

				top
				var class = input("What kind of variable?","Variable Type",default) as null|anything in list("Text","Num","Type","Person","Icon","File","Restore to default","List","Null")
				var new_value
				switch(class)
					if(null) return
					if("Restore to default")
						new_value = initial(M.vars[variable])

					if("Text")
						new_value = input("Enter new text:", "Text", M.vars[variable]) as null|text

					if("Num")
						new_value = input("Enter new number:", "Num", M.vars[variable]) as null|num

					if("Type")
						new_value = input("Pick a type:", "Type", M.vars[variable]) as null|mob|obj

					if("Person")
						new_value = choosePlayer("Pick a player:", "Person", M.vars[variable])

					if("File")
						new_value = input("Pick file:", "File", M.vars[variable]) as null|file

					if("Icon")
						new_value = input("Pick icon:", "Icon", M.vars[variable]) as null|icon

					if("List")
						input("This is what's in [variable]") as null|anything in M.vars[variable]

					if("Null")
						if(alert("Are you sure you want to clear this variable?", "Null", "Yes", "No") == "Yes")
							M.vars[variable] = null

				if(class != "Null")
					if(isnull(new_value))
						goto top
					M.vars[variable] = new_value

				LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[src] used Edit on [M]. [class]: [variable] Value: [M.vars[variable]]<br>")

			Click_Create(path as anything in typesof(/obj, /mob))
				set category = null
				set desc = "Click anywhere to make something. Right-click to deactivate."
				click_create = path
				if(path)
					aux_output("Click-create enabled: [path]", usr)
					LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] enabled click-create: [path]<br>")
				else
					aux_output("Click-create disabled.", usr)
					LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] disabled click-create.<br>")

			Click_Teleport()
				set category = null
				set desc = "Click anywhere to teleport to that location. Right-click to deactivate."
				click_teleport = !click_teleport
				aux_output("Click-teleport [click_teleport ? "enabled" : "disabled"].", usr)

			Create(O as anything in typesof(/obj, /mob))
				set category = null
				set desc = "Create any object or mob type."
				if(O)
					new O (loc)
					LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] created [O]<br>")

			MultiCreate(O as anything in typesof(/obj, /mob), n as num)
				set category = null
				set desc = "Create any number of any object or mob type."
				if(O && n > 0)
					for(var/i in 1 to n)
						new O (loc)
				LogAction("([time2text(world.realtime,"MM DD hh:mm")])(Admin)[key] created [O]<br>")

			Make_Key(id as text) new /obj/Item/Metal/Key (src, id)
			Make_Lock(id as text) new /obj/Item/Metal/Lock (src, id)

mob/Admin/verb/dump()
	var mob/O = choosePlayer("Who will you see all the variables of?","var dump")
	if(!O) return

	var V
	var vs
	for(V in O.vars)
		vs += "[V] = [O.vars[V]?O.vars[V] : "Undefined"]<br>"

	src << browse("<B>[O]'s variables</B><HR>[vs]")
	winshow(src, "browser_window")
