
#define FILE_DIR "notes/bloo"
#define FILE_DIR "notes/brump"
#define FILE_DIR "notes/thump"
#define FILE_DIR "notes/twang"


mob/player/verb/music(note as text)
	set instant = 1, hidden = 1
	var obj/Item/Tools/Instrument/i = equipment["main"]
	if(isSubscriber && istype(i) && (note in i.notes))
		hearers(src) << sound(i.notes[note])
		status_overlay("music", 10)

mob/player
	key_down(k)
		var flat	= has_key("alt")
		var sharp	= has_key("ctrl")
		var natural	= !(flat || sharp)
		switch(k)
			if("1")
				if(natural)		music("C")
				else if(sharp)	music("C#")
			if("2")
				if(natural)		music("D")
				else if(flat)	music("Db")
				else if(sharp)	music("D#")
			if("3")
				if(natural)		music("E")
				else if(flat)	music("Eb")
				else if(sharp)	music("F")
			if("4")
				if(natural)		music("F")
				else if(flat)	music("E")
				else if(sharp)	music("F#")
			if("5")
				if(natural)		music("G")
				else if(flat)	music("Gb")
				else if(sharp)	music("G#")
			if("6")
				if(natural)		music("A")
				else if(flat)	music("Ab")
				else if(sharp)	music("A#")
			if("7")
				if(natural)		music("B")
				else if(flat)	music("Bb")
				else if(sharp)	music("C8")
			if("8")
				if(natural)		music("C8")
				else if(flat)	music("B")
				else if(sharp)	music("C#8")
			if("9")
				if(natural)		music("D8")
				else if(flat)	music("Db8")
				else if(sharp)	music("D#8")
			if("0")
				if(natural)		music("E8")
				else if(flat)	music("Eb8")
				else if(sharp)	music("F8")
			if("-")
				if(natural)		music("F8")
				else if(sharp)	music("F#8")
			if("=")
				if(natural)		music("G8")
				else if(flat)	music("Gb8")
			else ..()

obj/Item/Tools/Instrument
	var tmp/notes[0]

	Twang
		icon = 'twang.dmi'
		notes = list(
			"C" = 'lute_c.ogg',
			"C#" = 'lute_c#-db.ogg',
			"Db" = 'lute_c#-db.ogg',
			"D" = 'lute_d.ogg',
			"D#" ='lute_d#-eb.ogg',
			"Eb" = 'lute_d#-eb.ogg',
			"E" = 'lute_e.ogg',
			"F" = 'lute_f.ogg',
			"F#" = 'lute_f#-gb.ogg',
			"Gb" = 'lute_f#-gb.ogg',
			"G" = 'lute_g.ogg',
			"G#" = 'lute_g#-ab.ogg',
			"Ab" = 'lute_g#-ab.ogg',
			"A" = 'lute_a.ogg',
			"A#" = 'lute_a#-bb.ogg',
			"Bb" = 'lute_a#-bb.ogg',
			"B" = 'lute_b.ogg',
			"C8" = 'lute_c8.ogg',
			"C#8" = 'lute_c#-db8.ogg',
			"Db8" = 'lute_c#-db8.ogg',
			"D8" = 'lute_d8.ogg',
			"D#8" ='lute_d#-eb8.ogg',
			"Eb8" = 'lute_d#-eb8.ogg',
			"E8" = 'lute_e8.ogg',
			"F8" = 'lute_f8.ogg',
			"F#8" = 'lute_f#-gb8.ogg',
			"Gb8" = 'lute_f#-gb8.ogg',
			"G8" = 'lute_g8.ogg')

	Bloo
		icon = 'bloo.dmi'
		notes = list(
			"C" = 'flute_c.ogg',
			"C#" = 'flute_c#-db.ogg',
			"Db" = 'flute_c#-db.ogg',
			"D" = 'flute_d.ogg',
			"D#" ='flute_d#-eb.ogg',
			"Eb" = 'flute_d#-eb.ogg',
			"E" = 'flute_e.ogg',
			"F" = 'flute_f.ogg',
			"F#" = 'flute_f#-gb.ogg',
			"Gb" = 'flute_f#-gb.ogg',
			"G" = 'flute_g.ogg',
			"G#" = 'flute_g#-ab.ogg',
			"Ab" = 'flute_g#-ab.ogg',
			"A" = 'flute_a.ogg',
			"A#" = 'flute_a#-bb.ogg',
			"Bb" = 'flute_a#-bb.ogg',
			"B" = 'flute_b.ogg',
			"C8" = 'flute_c8.ogg',
			"C#8" = 'flute_c#-db8.ogg',
			"Db8" = 'flute_c#-db8.ogg',
			"D8" = 'flute_d8.ogg',
			"D#8" ='flute_d#-eb8.ogg',
			"Eb8" = 'flute_d#-eb8.ogg',
			"E8" = 'flute_e8.ogg',
			"F8" = 'flute_f8.ogg',
			"F#8" = 'flute_f#-gb8.ogg',
			"Gb8" = 'flute_f#-gb8.ogg',
			"G8" = 'flute_g8.ogg')

	Brump
		icon = 'brump.dmi'
		notes = list(
			"C" = 'trump_c.ogg',
			"C#" = 'trump_c#-db.ogg',
			"Db" = 'trump_c#-db.ogg',
			"D" = 'trump_d.ogg',
			"D#" ='trump_d#-eb.ogg',
			"Eb" = 'trump_d#-eb.ogg',
			"E" = 'trump_e.ogg',
			"F" = 'trump_f.ogg',
			"F#" = 'trump_f#-gb.ogg',
			"Gb" = 'trump_f#-gb.ogg',
			"G" = 'trump_g.ogg',
			"G#" = 'trump_g#-ab.ogg',
			"Ab" = 'trump_g#-ab.ogg',
			"A" = 'trump_a.ogg',
			"A#" = 'trump_a#-bb.ogg',
			"Bb" = 'trump_a#-bb.ogg',
			"B" = 'trump_b.ogg',
			"C8" = 'trump_c8.ogg',
			"C#8" = 'trump_c#-db8.ogg',
			"Db8" = 'trump_c#-db8.ogg',
			"D8" = 'trump_d8.ogg',
			"D#8" ='trump_d#-eb8.ogg',
			"Eb8" = 'trump_d#-eb8.ogg',
			"E8" = 'trump_e8.ogg',
			"F8" = 'trump_f8.ogg',
			"F#8" = 'trump_f#-gb8.ogg',
			"Gb8" = 'trump_f#-gb8.ogg',
			"G8" = 'trump_g8.ogg')

	Dum
		icon = 'dum.dmi'
		notes = list(
			"C" = 'drum_c.ogg')