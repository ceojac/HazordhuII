
//	a list containing the active title-screen wanderers
var Titles[0]

//	a list containing all players (non NPCs)
var Players[0]

//	a list containing online admins.
var AdminsOnline[0]

proc/is_admin(mob/player/p) return istype(p) && (p.key in Admins)

world
	mob = /mob/player

mob/player
	var
		tmp/AtTitleScreen = false

		//	the changelog is only shown if there's changes you haven't seen yet
		last_version_seen

	proc/view_login_message()
		client.center_window("login_message")
		src << output(null, "loginoutput")
		src << output(LoginMessage(), "loginoutput")
		winshow(src, "login_message")

mob/player
	Login()
		..()
		get_client_info(client)
		winset(src, null, "reset=true")

		client.focus = src

		cid = client.computer_id

		if(Admins.Find(key) || NewGods.Find(key))
			verbs += typesof(/mob/Admin/verb)
			AdminsOnline.Add(src)
			isAdmin = true
			client.control_freak = false

		set_loc()

		var const/BYOND_VERSION = 498
		if(client.byond_version < BYOND_VERSION)
			spawn(-1) s_alert("This game was made in \n\tBYOND [BYOND_VERSION] (yours is [client.byond_version]) \n\nPick up the latest version <a href='http://www.byond.com/download/build/LATEST/'>here</a>.","Warning", "OK")
			del src

		AdminsOnline << "<i>[key] is logging in.</i>"

	#if 0 // multikeying allowed?
		for(var/client/C)
			if(C == client) continue
			if(C.mob && C.mob.isAdmin) continue
			if(key in Admins) continue
			else
				if(C.computer_id == client.computer_id)
					spawn(-1) s_alert("Only one user can be logged in from your computer at a time.", "Invalid Login", "OK")
					del src
					return
	#endif

		client.screen += newlist(	/obj/Title_Screen/Hazordhu,
									/obj/Title_Screen/II,
									/obj/Title_Screen/Loadgame2,
									/obj/Title_Screen/Newgame2)

		world.log << "([time2text(world.realtime,"MM DD hh:mm")])[src] logs in."

	#if PLAYERSAVE
		if(fexists(save_path())) see_invisible = 5
	#endif

		icon = null
		Locked = true
		Players |= src

		AtTitleScreen = true

		set_title_screen()
		var title_list[0]
		for(var/mob/title/m) title_list.Add(m)
		var mob/title/title = pick(title_list)
		title.start_wandering(client)
		while(AtTitleScreen || client.char_creator) sleep 1
		set_game_screen()

		title.stop_wandering(client)
		for(var/obj/Title_Screen/ts in client.screen)
			client.screen -= ts

		see_invisible = false
		Locked = false
		Made = true

		if(!DevelopmentServer)
			if(!(key in TOS_List))
				client.center_window("tos")
				src << output(null, "terms")
				src << output(TOS, "terms")
				winshow(src, "tos")

		Regen()
		if(!KO)
			var conc = Hood_Concealed
			icon_reset()
			Hood_Concealed = conc

		else
			KO = false
			KO()

		if(!GodMode)
			if(istype(loc, /turf/Environment/Ocean) && !(locate(/obj/Built) in loc))
				die("drowning")

		death_check()
		InventoryGrid()

		LoginCheck()

		_Gender = "[uppertext(copytext(gender, 1,2))][copytext(gender,2)]"
		if(!aeon) aeon = get_aeon()
		if(!moon) moon = get_moon()
		if(!x) Respawn()
		if(zombie_infection > 0)
			spawn(1) ZombieInfected()

		if(!ooc_listen)
			winset(src, "ooc_toggle_button", "is-checked=false")
			winset(src, "ooc_button", "is-disabled=true")

		if(locate(/obj/Built/Stocks) in loc) Locked = 1

		if(!GodMode)
			emote("materializes from the void!")
			for(var/obj/Mining/cave_walls/d in loc)
				if(d.density)
					die("a cave-in")
					break
			for(var/obj/Woodcutting/t in loc)
				step_rand(src)
				break

		if(drunk_loop)
			drunk_loop = false
			drunk_loop()

		if(!charID) charID = string()

		status_clear()

		icon_turn()

		if(GodMode)
			GodMode = 0
			var mob/Admin/a = src
			a.GhostForm()

			if(invisibility)
				invisibility = 0
				a.Toggle_Visibility()

		SET_TBOUNDS("11,4 to 22,12")

		PostLogin()

		if(!ghost_logged) world << "<i>[key] has logged in.</i>"

	PostLogin()
		..()
		spawn(1)
			if(last_version_seen != BUILD)
				last_version_seen = BUILD
				view_login_message()

			spawn
				season_update()
				season_update()

			spawn typing_check()

	Logout()
		PreLogout()

		if(!ghost_logged) world << "<i>[key] has logged out.</i>"
		status_clear()

		if(!GodMode) emote("vanishes into the void!")

		Players -= src
		AdminsOnline -= src

		if(Made) Save()

		if(mount) del mount

		world.log << "(([time2text(world.realtime,"MM DD hh:mm")]))[key] logs out."
		del src

	Del()
		Players -= src
		..()