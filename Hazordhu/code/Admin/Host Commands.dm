
//Commands that can be called through Dream Daemon! :D
world/Topic(T, Addr, Master, Key)
	..()
	if(Master)
		var/colon=findtext(T,":")
		if(colon)
			var/cmd=copytext(T,1,colon)
			var/next=copytext(T,colon+1)

			switch(cmd)
				if("shout")
					world<<"[Host] says: [next]"
				if("mute")
					for(var/client/m)if(m.key==next && m.mob)
						Host.Mute(m.mob)
				if("adminchat")
					Host.adminchat(next)
		else
			switch(T)
				if("war")
					Host.War()

var/mob/Admin/Host/Host=new
mob/Admin/Host
	name="The Host"