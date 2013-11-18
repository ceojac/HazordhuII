mob/NPC/Undead
	Race="Undead"
	friendly_types = list(/mob/NPC/Undead/Archer,/mob/NPC/Undead/Skeleton,/mob/NPC/Undead/Skeleton_War,/mob/NPC/Undead/Soul,/mob/NPC/Zombie,/mob/NPC/Zombie/Archer,/mob/NPC/Zombie/Enforcer, /mob/NPC/Undead/Shadow)
	New()
		var weapon = pick(normal_weapons)
		equip(new weapon (src))

		var shield = pick(normal_shields)
		equip(new shield (src))

		var plate_suit[] = list(
			/obj/Item/Armour/Shirt/Plate_Shirt,
			/obj/Item/Armour/Pants/Plate_Legs,
			/obj/Item/Armour/Hands/Gauntlets,
			/obj/Item/Armour/Feet/Greaves)

		var chain_suit[] = list(
			pick(
				/obj/Item/Armour/Shirt/Chainmail,
				/obj/Item/Armour/Shirt/Short_Mail),
			/obj/Item/Armour/Pants/Mail_Pants,
			/obj/Item/Clothing/Feet/Fur_Boots)

		var suit[] = pick(plate_suit, chain_suit)
		for(var/type in suit)
			equip(new type (src))
		..()

	Soul
		icon='code/Mobs/Spirit.dmi'
		name = "Lost Soul"
		density=0
		Strength=100
	//	Defense=100
		Health=3000
	Skeleton
		icon='code/Mobs/Skeleton.dmi'
		name = "Skeleton"
		density=1
		Strength=5
	//	Defense=1
		Health=65
		SkinType=/obj/Item/Bone
	Skeleton_War
		icon='code/Mobs/Skeleton.dmi'
		name = "Skeleton Warrior"
		density=1
		Strength=5
	//	Defense=1
		Health=140
		SkinType=/obj/Item/Bone
	Archer
		icon='code/Mobs/Skeleton.dmi'
		name = "Skeleton Archer"
		density=1
	//	Archery_Level=15
		Strength=5
	//	Defense=1
		Health=45
		SkinType=/obj/Item/Bone
		New()
			var weapon = pick(ranged_weapons)
			equip(new weapon (src))
			..()