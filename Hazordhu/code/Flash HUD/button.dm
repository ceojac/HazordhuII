hud/button
	parent_type = /obj
	icon = 'code/flash hud/hud icons 32.dmi'
	icon_state = "cell"
	layer = 200

	New(client/c) if(istype(c)) c.screen += src

	var expands = false
	var expanded = false
	proc/toggle() expanded ? collapse() : expand()
	proc/expand() if(!expanded)
		expanded = true
		expanded()
		return true
	proc/collapse() if(expanded)
		expanded = false
		collapsed()
		return true
	proc/expanded()
	proc/collapsed()

	Click()
		if(expands) toggle()
		..()

	var text_size = 1
	var text_align = "center"
	var text_valign = "middle"
	proc/set_text(t) maptext = "<font size=[text_size] align=[text_align] valign=[text_valign]>[t]"