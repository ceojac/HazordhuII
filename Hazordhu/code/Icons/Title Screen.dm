obj/Title_Screen
	layer = EFFECTS_LAYER
	Hazordhu
		icon = 'Title.dmi'
		name = "Hazordhu II"
		icon_state = "Hazordhu"
		opacity = 0
		screen_loc = "CENTER-2,CENTER+2"

	II
		icon = 'Title.dmi'
		name = "Hazordhu II"
		icon_state = "IIa"
		opacity = 0
		screen_loc = "CENTER-2,CENTER+2:-4"
		New()
			..()
			layer --

	Newgame2
		icon = 'TitleNew.dmi'
		name = "Create New Character"
		opacity = 0
		screen_loc = "CENTER-2:16,CENTER-1:-10"
		Click()
			if(map_loading) return
			var mob/player/p = usr
			if(!p.Made && p.AtTitleScreen && p.client.start_char_create())
				p.AtTitleScreen = false

	Loadgame2
		icon = 'TitleLoad.dmi'
		opacity = 0
		name = "Load Existing Character"
		invisibility = 5
		screen_loc = "CENTER-2:16,CENTER-4"
		Click()
			if(map_loading) return
			var mob/player/p = usr
			if(!p.Made && p.AtTitleScreen && p.Load())
				p.AtTitleScreen = false

mob/title
	invisibility = 101
	SET_STEP_SIZE(2)
	density = false

	var clients[0]
	proc/start_wandering(client/c)
		clients |= c
		c.perspective = EYE_PERSPECTIVE
		c.eye = src
	#if PIXEL_MOVEMENT
		walk_rand(src)
	#else
		walk_rand(src, 4)
	#endif
		Titles |= src

	proc/stop_wandering(client/c)
		clients -= c
		c.perspective = MOB_PERSPECTIVE
		c.eye = c.mob
		if(!clients.len)
			walk(src, 0)
			Titles -= src