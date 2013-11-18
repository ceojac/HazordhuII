var action_log[0]
var action_log_save_path = "Data/actions.sav"
proc/save_action_log()
	var savefile/s = new (action_log_save_path)
	s << action_log
proc/load_action_log() if(fexists(action_log_save_path))
	var savefile/s = new (action_log_save_path)
	s >> action_log
world/New() { ..(); load_action_log() }
world/Del() { save_action_log(); ..() }

mob/Admin
	verb/action_log()
		var ckey = input(src, "Which action log will you view?", "Action Log") as null|anything in action_log
		if(isnull(ckey)) return

		var display = "<b>Action Log for [ckey]:</b><hr><ul>"
		for(var/action in action_log[ckey])
			display += "<li>[action]</li>"
		display += "</ul>"

		src << browse(display)
		winshow(src, "browser_window")

mob/player
	proc/log_action(action)
		if(!action_log[ckey]) action_log[ckey] = list()
		action_log[ckey] += "\[[current_time()]] [key] ([charID]) [ADMIN_TELE(src)]: [action]"