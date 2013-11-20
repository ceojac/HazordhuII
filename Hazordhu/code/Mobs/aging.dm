mob
	var max_age = 0

	proc/AgeUp()
		Age = get_aeon() - aeon
		src << "It is your birthmoon!  You are [Age-1] Aeon\s old!"
		CheckAge()

	proc/CheckAge()