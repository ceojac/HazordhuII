
obj/Woodcutting
	parent_type = /obj/Resource
	resource = /obj/Item/Wood/Log
	Tree
	Tree

obj/Mining
	parent_type = /obj/Resource
	cave_walls
		dirt
		stone
		clay
		metal
		hazium

obj/Resource
	var infinite = 0
	var resources = 0
	var resource

	var experience = 0
	var level_requirement = 0