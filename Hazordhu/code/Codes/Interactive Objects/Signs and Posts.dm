obj/Built
	Sign
		parent_type = /obj/Built/Signs
		write_with = /obj/Item/Coal

	Stone_Sign
		parent_type = /obj/Built/Signs
		write_with = /obj/Item/Tools/Chisel

	Statue
		parent_type = /obj/Built/Signs
		write_with = /obj/Item/Tools/Chisel

	Tombstone
		parent_type = /obj/Built/Signs
		write_with = /obj/Item/Tools/Chisel

	Tether_Post
		SET_TBOUNDS("13,7 to 20,14")
		icon = 'code/Woodworking/Tether Post.dmi'
		interact(mob/m) Use(m)

		proc/Use(mob/humanoid/m)
			if(!m.mount) return
			m.emote("ties [m.mount] to the post")
			m.mount.posted = true
			m.mount.Locked = true
			m.mount.dismount(m)

obj/Built/Signs
	var write_with

	var write_log
	var Writing

	var tmp/obj
		reader
		reader_text

	proc/write(mob/humanoid/m)
		var has_writer
		if(ispath(write_with, /obj/Item/Tools))
			has_writer = m.is_equipped(write_with)
		else has_writer = locate(write_with) in m

		if(has_writer)
			desc = input(m, "Write on the sign:", "Sign", desc) as message
			write_log += "<b>[m.key]</b> wrote: <i>[desc]</i><br>"
			return 1

		else if(m.GodMode)
			read(m)
			return 1

	proc/read(mob/m)
		if(desc)
			m.aux_output("The sign says: <i>[desc]</i>")
		else m.aux_output("The sign is blank.")
		return true

	interact(mob/m) read(m)
	interact_right(mob/m) write(m)