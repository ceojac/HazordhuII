//--------------------------------
// Events Scheduling
//--------------------------------


// This is the datum used to handle the scheduled events
schedule
	var
		events[0]

		time		// how long the schedule has been running in SECONDs

	New()
		events = newlist(
					//	/event/season,
					#if LIGHTING_ENABLED
						/event/lighting,
					#endif
					//	/event/weather
						)

		spawn for()
			sleep(SECOND)

			time ++

			for(var/event/e in events)
				if( !(time % e.time) )
					e.execute()


//	Initialization of the schedule
var
	schedule/event_schedule

	event
		lighting/event_lighting


world
	New()
		..()
		event_schedule = new
		event_lighting = locate() in event_schedule.events



//---------------------------
// Scheduled Events
//---------------------------

event
	var
		time = 1	// time in MINUTEs to cycle

	proc
		execute() // execute() is the proc that is called when the event occurs as determined by the schedule
			//world.log << "<b><font color=\"##0000FF\">Executing [src]</font></b>"
