var HumanGodLog
var OrcGodLog
var ElfGodLog
mob/proc/GodLog(t as text) switch(Race)
	if("Human") HumanGodLog += "[html_encode(t)]<br>"
	if("Orc") OrcGodLog += "[html_encode(t)]<br>"
	if("Elf") ElfGodLog += "[html_encode(t)]<br>"

obj/Built/Altar
	interact(mob/m)
		switch(alert(m, "Pray or Offering?", "Worship", "Pray", "Offering", "Cancel"))
			if("Pray")
				var prayer = input(m, "Type your prayer in. ", "Pray")as message
				if(prayer)
					AdminsOnline << "<b>New Prayer from [m] ([m.key]): [prayer]"
					m.GodLog("[m] prays: [prayer] ([m.x],[m.y],[m.z] [time2text(world.realtime,"MM DD hh:mm")])")

			if("Offering")
				var obj/Item/item = input("Select what item you want to offer to your god.","Offering") as null|obj in (m.contents - m.Equipment())
				if(item)
					AdminsOnline << "<b>New Offering from [m] ([m.key]): [item]"
					m.GodLog("[m] offers \his [item]. ([m.x],[m.y],[m.z] [time2text(world.realtime,"MM DD hh:mm")])")
					del item