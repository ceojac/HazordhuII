var normal_weapons[] = list(
	/obj/Item/Weapons/Axe,
	/obj/Item/Weapons/Sword,
	/obj/Item/Weapons/Dagger,
	/obj/Item/Weapons/Spear,
	/obj/Item/Weapons/Mace)

var normal_shields[] = list(
	/obj/Item/Weapons/Shield,
	/obj/Item/Weapons/Buckler,
	/obj/Item/Weapons/Wooden_Shield)

var fancy_weapons[] = list(
	/obj/Item/Weapons/Broadaxe,
	/obj/Item/Weapons/Corseque,
	/obj/Item/Weapons/Glaive,
	/obj/Item/Weapons/Flail,
	/obj/Item/Weapons/Halberd,
	/obj/Item/Weapons/Longsword,
	/obj/Item/Weapons/Sabre,
	/obj/Item/Weapons/Sparth)

var fancy_shields[] = list(
	/obj/Item/Weapons/Tower_Shield,
	/obj/Item/Weapons/Kite_Shield,
	/obj/Item/Weapons/Wooden_Kite)

var normal_helmets[] = list(
	/obj/Item/Armour/Helmet/Coif,
	/obj/Item/Armour/Helmet/Metal_Helmet)

var fancy_helmets[] = list(
	/obj/Item/Armour/Helmet/Metal_Helmet_North,
	/obj/Item/Armour/Helmet/Plate_Helmet,
	/obj/Item/Armour/Helmet/Plate_Helmet_Plume,
	/obj/Item/Armour/Helmet/Plate_Helmet_Plume_Visor,
	/obj/Item/Armour/Helmet/Plate_Helmet_Reinforced,
	/obj/Item/Armour/Helmet/Plate_Helmet_Visor)

var ranged_weapons[] = list(
	/obj/Item/Weapons/archery/Bow,
	/obj/Item/Weapons/archery/Crossbow)


var plate_suit[] = list(
	/obj/Item/Armour/Shirt/Plate_Shirt,
	/obj/Item/Armour/Pants/Plate_Legs,
	/obj/Item/Armour/Hands/Gauntlets,
	/obj/Item/Armour/Feet/Greaves,
	pick(fancy_helmets))

var chain_suit[] = list(
	pick(
		/obj/Item/Armour/Shirt/Chainmail,
		/obj/Item/Armour/Shirt/Short_Mail),
	/obj/Item/Armour/Pants/Mail_Pants,
	/obj/Item/Clothing/Feet/Fur_Boots,
	pick(normal_helmets))

var leather_suit[] = list(
	/obj/Item/Clothing/Back/Quiver,
	/obj/Item/Clothing/Feet/Leather_Shoes,
	/obj/Item/Clothing/Hands/Leather_Gloves,
	/obj/Item/Clothing/Pants/Leather_Pants,
	/obj/Item/Clothing/Shirt/Leather_Shirt)