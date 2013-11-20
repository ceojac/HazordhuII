mob/proc	//	Garbages
	_garbage(obj/Built/Garbage/o) if(istype(o)) spawn
		var items[] = contents.Copy()
		for(var/obj/Item/i in items) if(is_equipped(i)) items -= i
		var/obj/Item/trash = input("What would you like to throw away?")as null|anything in items
		if(!trash) return
		del trash
		return 0