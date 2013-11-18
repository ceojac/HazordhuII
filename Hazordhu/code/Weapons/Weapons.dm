obj
	Item
		Weapons
			Type = "Offense"	//or Defense
			var
				Sharpness	=	0
				aType		// "[aType]ing" is shown in the combat message

				Range		=	1
				ParryChance	=	25
				Damage		=	10
				Defense		=	0

			value = 18
			Sharpness = 5
			Stackable = 0

			use(mob/humanoid/m)
				if(Type != "Defense")
					Sharpness = min(max(Sharpness, 1), 100)

					var status
					switch(Sharpness)
						if( 1 to  5)	status = "dull"
						if( 6 to 12)	status = "dulling"
						if(13 to 20)	status = "adequately sharp"
						if(21 to 49)	status = "sharpened"
						if(50 to 100)	status = "very sharp"

					m << "[(m.is_equipped(src)) ? "Your" : "The"] [initial(name)] is [status]."

			Javelin
				icon='code/Weapons/Javelin.dmi'
				Damage=3
				Type="Offense"
				aType="throw"
			Buckler
				icon='code/Weapons/Buckler.dmi'
				Defense=3
				Type="Defense"
			Dagger
				icon = 'code/Weapons/Dagger.dmi'
				ParryChance = 15
				Damage=10
				Type="Offense"
				aType="lung"

			Sword
				icon = 'code/Weapons/Sword.dmi'
				ParryChance = 40
				Damage = 15
				Type="Slash"
				aType="slash"
			Sabre
				icon = 'code/Weapons/Sabre.dmi'
				ParryChance = 40
				Damage = 18
				Type="Slash"
				aType="slash"
			Longsword
				icon = 'code/Weapons/Longsword.dmi'
				ParryChance = 40
				Damage = 20
				Type="Slash"
				aType="slash"

			Spear
				icon = 'code/Weapons/Spear.dmi'
				Range = 2
				ParryChance = 20
				Damage = 12
				Type="Pierce"
				aType="stab"
			Corseque
				icon = 'code/Weapons/Corseque.dmi'
				Range = 2
				ParryChance = 20
				Damage = 15
				Type="Pierce"
				aType="stab"
			Glaive
				icon = 'code/Weapons/Glaive.dmi'
				Range = 2
				ParryChance = 20
				Damage = 18
				Type="Pierce"
				aType="stab"

			Halberd
				icon = 'code/Weapons/Halberd.dmi'
				Range = 2
				ParryChance = 20
				Damage = 10
				Type="Pierce"
				aType="stab"

			Axe
				icon = 'code/Weapons/Axe.dmi'
				ParryChance = 30
				Damage = 15
				Type="Slash"
				aType="swing"
			Sparth
				icon = 'code/Weapons/Sparth.dmi'
				ParryChance = 30
				Damage = 20
				Type="Slash"
				aType="swing"
			Broadaxe
				icon = 'code/Weapons/Broadaxe.dmi'
				ParryChance = 30
				Damage = 23
				Type="Slash"
				aType="swing"

			Mace
				icon = 'code/Weapons/Mace.dmi'
				ParryChance = 30
				Damage = 15
				Type="Bash"
				aType="swing"
			Flag
				icon = 'code/Weapons/bearer flag.dmi'
				ParryChance = 40
				Damage = 10
				Type="Bash"
				aType="swing"
			Flail
				icon = 'code/Weapons/Flail.dmi'
				ParryChance = 30
				Damage = 15
				Type="Bash"
				aType="swing"

			Meathook // this is for Kai
				icon = 'code/Smithing/Meathook.dmi'
				ParryChance = 30
				Damage = 30
				Type = "Pierce"
				aType = "lung"

			Shield
				icon = 'code/Weapons/Shield.dmi'
				Defense=10
				Type="Defense"
			Tower_Shield
				icon = 'code/Weapons/Tower Shield.dmi'
				Defense=15
				Type="Defense"
			Kite_Shield
				icon = 'code/Weapons/Kite Shield.dmi'
				Defense=12
				Type="Defense"
			Wooden_Kite
				icon = 'code/Weapons/Wooden Kite Shield.dmi'
				Defense=10
				Type="Defense"
			Wooden_Shield
				icon = 'code/Weapons/Wooden Shield.dmi'
				Defense=7
				Type="Defense"
