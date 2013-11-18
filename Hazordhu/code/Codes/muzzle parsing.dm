var consonants[] = list(
	"b", "c", "d", "f",
	"g", "h", "j", "k",
	"l", "m", "n", "p",
	"q", "r", "s", "t",
	"v", "w", "x", "z")

proc/muffle(msg as text)
	var encoded = ""
	for(var/i in 1 to length(msg))
		var char = copytext(msg, i, i + 1)
		if(lowertext(char) in consonants)
			encoded += "m"
		else if(!isletter(char))
			encoded += char
		else encoded += "f"
	return encoded