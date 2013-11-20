mob/NPC
	SET_STEP_SIZE(2)

	proc/playerFound()
		return locate(/mob/player) in ohearers(src)