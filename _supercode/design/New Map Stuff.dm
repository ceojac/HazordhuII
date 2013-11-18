/*

Foreword

This is where I'll be working on implementing the new map stuff for use in a future update.
TO THE OTHER DEVS:  Feel free to tack any notes you see fit in the notes section, but please don't modify any code here.  Kaio, that means you.


NOTES

Tack comments and notes here, please
- F0lak


--END NOTES

Design Ideas

		Implementing a pre-designed M&B style world map, and scenes to be generated randomly.  The world map will be an overview of the entire
		world (likely even all of the world as seen in The Galadar Project (ie: Haz 3)).  Certain pre-designed scenes on this map would serve RP
		purposes, like are seen in TGP.

		The World Map

			The world map will be predesigned by myself and will feature several prebuilt settlements.
			On the world map will be parties.  These will be anything from large armies to small bands of bandits to herds of animals you can hunt (or flee from)
			Parties will be nondense and can be travelled through, but through interaction (either a context menu or some other form of interaction) will able to
			be conversed with or a battle will be initiated.  NPC parties will follow their own AI, and will be only roving bandit tribes until more features are
			added to provide relation to certain factions in the game world.

			Naval travel will require the use of a dock (a special settlement built on the coastline)

		Scenes
			Scenes would be the detailed area views generated randomly.  A scene would be made when a player settles an area, or a battle commences.

				Settlements would save and load on the fly as they're needed.  For this we need speed that won't bog down the server.
				They'll initally generate randomly, but after that the terrain and objects in them will save.
				They'll be entered via the world map, and players entering them will spawn at a location on the edge of the map chosen by the
				person creating the settlement.

				Battle Scenes will recycle the same Z levels if possible.  Here is how a battle will work:

					Attacker: Spawns on the edge from which they attacked from the world map
					Defender: Spawns on the middle of the map
					Parties spawn with the attacker and defender (cap of units on the field will likely be something small (15 per side))
					The two sides will fight until a victor is decided.  Either side will have the option to surrender at any given time
		Parties
			Players can join up with parties and the party leader controls movement on the world map.
			Parties have differnet icons depending on what kind of party they are.
				default is a person walking or mounted
				on water is a boat
				with a cart is a carvan icon
				with soldiers has an overlay of each soldier type, ranged, melee, and cavalry
*/
