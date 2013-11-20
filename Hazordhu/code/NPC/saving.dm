
var const/npc_save = "Data/Map/npc.sav"
proc
	manage_npc(cmd)
		switch(cmd)
			if("save")
				fdel(npc_save)
				var savefile/F = new (npc_save)
				var L[0]
				for(var/mob/NPC/N in world)
					if(istype(N, /mob/tutor)) continue
					if(N.loc)
						N.saved_x = N.x
						N.saved_y = N.y
						N.saved_z = N.z
						L += N
				if(L.len)
					F << L

			if("load")
				if(fexists(npc_save))
					var savefile/F = new (npc_save)
					var L[0]
					F >> L
					if(!L) return

					for(var/mob/NPC/N in world)
						if(istype(N, /mob/tutor)) continue
						if(N.loc)
							del N

					for(var/mob/NPC/N in L)
						N.set_loc(locate(N.saved_x, N.saved_y, N.saved_z))