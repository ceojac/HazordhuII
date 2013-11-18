var const/TOS_PATH = "Data/tos.sav"

world/New()
	loadTOS()
	..()

world/Del()
	saveTOS()
	..()

proc/saveTOS()
	fdel(TOS_PATH)
	if(!TOS_List.len) return
	new /savefile (TOS_PATH) << TOS_List

proc/loadTOS()
	if(!fexists(TOS_PATH)) return
	var savefile/tos = new (TOS_PATH)
	tos >> TOS_List

mob/player
	verb/terms()
		set hidden = true
		winshow(src, "tos", false)
		TOS_List.Add(key)

	proc/LoginCheck()
		var days = client.CheckPassport(SUB_PASSPORT)
		if(days)
			if(days == -1)
				aux_output("You're a lifetime subscriber!")
			else aux_output("You're a subscriber for [days] more day\s!")
			isSubscriber = true
			if(!SubBens)
				MaxHealth	+=	10
				Health		+=	10

				Stamina		+=	10
				MaxStamina	+=	10

				Strength	+=	5
				Item_Limit	=	20
				SubBens		=	true

		else if(SubBens)
			MaxHealth	-=	10
			Health		-=	10
			Stamina		-=	10
			MaxStamina	-=	10
			Strength	-=	5
			Item_Limit	=	15
			SubBens		=	false

		if(client.IsByondMember())
			aux_output("You are a BYOND member!")
			isBYONDMember	=	true
			if(!MemBens)
				MaxHealth	+=	10
				Health		+=	10

				Stamina		+=	10
				MaxStamina	+=	10

				Strength	+=	5
				Item_Limit	=	20
				MemBens		=	true

		else if(MemBens)
			MaxHealth	-=	10
			Health		-=	10

			Stamina		-=	10
			MaxStamina	-=	10

			Strength	-=	5
			Item_Limit	=	15

		//	this is to update the number of items text
		InventoryGrid()
