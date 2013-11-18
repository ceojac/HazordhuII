"	Go here instead: https://docs.google.com/document/d/1uZ0_bDzUM5WRJm-u-qwvISrgnovCfLsXvyQZm2RFiEE/edit

/*
"	 This is a list of things to do, like fix bugs, glitches, and experiment with possible new systems.
"	 Usually, I fix bugs and glitches as soon as I hear about them, but not always, so that list will always be short.
" -: unresolved
" +: resolved
" ?: is it a bug?

{"	Ideas

- Always keep an eye out for controls improvements.

- A more personal chat log for admins: view the chat from a certain person's perspective

- Necro armor should be made from special undead bones dropped only by undead corpses (zombies, skeletons)

- It's hard to herd animals because only harnessed/collared animals save. Maybe put collars on sty?
- Re-add nest functionality (animal breeding, player mating)
- Re-add Staff herding functionality
- Fetch command for Ruffs

+ Garbage Cans can just be storage objects. Someone would have to manually empty them somewhere, though.
- New fence gates that align with the fences
- Move furniture around in pixel movement
- Ability to rotate objects: (some would need drawn)
 - archery target
 - bed
 - bookshelf
 - breakdown counter
 - chest
 - sink
 - etc.
 + chair
 + cooking range
 + counter
 + throne
- Sink functionality:
 + Act as a filler for fluid containers
 - Should be toggle-able for water coming out of it.
 - Maybe even plugged so it fills, and it unfills when unplugged.
 - Also be used for storing cooking-related things like plates, bowls, spoons, pots, pans
- Change the crafting statbars to grids

- Non-overlay "item" states for clothing and armor
- Clothes on over and/or under armor (separate cloth/armor slots)


"}

for 6024:
{"
- Crafting into inventory past weight limit should drop excess
+ Main-interact with peeks to tame, instead of friggin double-right-click

- Farming change:
 - Farming is time-based instead of season-based
 + Add seeds for Lettif
 + Add Shurgercane (makes Caramel with mylk)
 + Yeese is its own seed (always should have been)
 - Certain crops can only grow during certain seasons:
  - Phluf: Spring-Summer
  - Kurn, Huff: Fall
  - Puteta, Karet: Fall, Winter
  - Murshums, Yeese: All year, but can only be planted underground
  - Lettif: Summer
  - Shurgercane: Fall

- Auto-equip necessary tools more often
- Tool durability dependent on the skill level of the crafter
- Repair tools at an anvil, limited to the level you could craft them at

- Move Boards and Bricks to Carving and Masonry for constistency
+ Harvesting from a farm turns it back into a path
+ Right-click shovel to dig at your current position

+ Make plants not move with the obelisk

? Do something about the spammy action emotes
- Display the group flag in the black thingy by the group name
- Improve balance for building health, player damage, armor defense, etc.
+ Bookshelf should be able to store books
 - What else can a bookshelf store?
 - Maybe its icon changes according to how many books are in it?

+ Cast a ray to determine if you can interact with stuff, rather than check distance
 ? Could cause issues with putting items on tables
 + maybe a variable "action_block" to determine what a ray can pass through
+ Placing items on tables and rotated counters is not right
 + It's somewhat better

+ Jungle glitches:
 + A large jungle cave ends in the middle of grass
  + Added proper exits
 + A waterfall ends in an area with a small cave with hazium inside, but it's a one-way trip
  + I just blocked it with sharp rocks
 + The rivers don't flow
  + Made a new River type (along with a no-freeze version)

+ Agriner AI: charge in the initial direction to the enemy for a certain distance without turning.
- Shields do not affect animal attacks

+ Balls didn't bounce properly.
+ Sink wasn't craftable

+ Changed player movement to use custom pixel movement through move()
- Refactoring some key interactions
+ Refactored berry-picking
+ walk_speed, run_speed, god_speed variables for movement speed

+ The InfernoSplosion bow mod didn't work properly
+ Metal Coins had the name "Hazium Coins"
"}

for 6023:
{"
- Water wheel still spins when the season changes to Shiverstide
+ Friggin add Coin Stamps
"}

for 6022:

for 6021:
{"	Misc

- Placing items on tables and rotated counters is not right
- It's hard to herd animals because only harnessed/collared animals save. Maybe put collars on sty?

"}

{"	Bugs
Previous
- Fences don't always fix themselves when things around them disappear
- Bearer's Flag isn't animated
- Update the Controls text for combat
? The game keeps friggin crashing randomly.
? Sometimes the game starts running very slowly and it doesn't stop until rebooted.

New

"}

for 6020:
{"	Misc

- It's hard to herd animals because only harnessed/collared animals save. Maybe put collars on sty?

"}

{"	Bugs
Previous
- Fences don't always fix themselves when things around them disappear
- Bearer's Flag isn't animated
- Update the Controls text for combat
? The game keeps friggin crashing randomly.
? Sometimes the game starts running very slowly and it doesn't stop until rebooted.
+ Force-feeding doesn't work completely

New
+ Trying to take food off of the Range will rotate it instead. (conflicting controls)
+ Mounts aren't loading properly when mounted
+ Water Wheel doesn't spin the grinding stone in Frostmelt, but it does in Shiverstide
+ Carts didn't properly follow olihant-riders.
+ Can Set Language to null for a "{you} says in : {text}" message
+ Mounts are somehow taking stamina sometimes when running, causing KO
+ You can harvest freshly-planted crop seeds for more than one seed
+ Can't write on Statues or Tombstones
+ You can't mylk murs (which should be a female-only thing)
+ Murs didn't spawn with proper genders
+ Players and map-saved objects should retain their step_x/y positions.

"}

for 6019:
{"	Misc

? Archers need to be nerfed
+ The map saves fully every 30 minutes

"}

{"	Bugs

+ Olihant's mounted pixel offset is off on the X
+ Force-feeding liquid doesn't work
- Fences don't always fix themselves when things around them disappear

+ Books can't be titled/signed
+ Book-reading window is resizeable

"}

for 6018:
{"	Misc.

- Update the Controls text for combat

+ Mouse-aimed melee is re-added, but if the mouse isn't on the map, your dir will stay according to your movement.
	This also works with Archery. Press R to ready an arrow, and Space to shoot.
	R is also Block.
+ Middle-click equips equipment. Dragging into equipment is no longer necessary if you have this handy mouse button!

"}

{"	Bugs


- Bearer's Flag isn't animated

- The game keeps friggin crashing randomly.
- Sometimes the game starts running very slowly and it doesn't stop until rebooted.

? Permafrost ice can't be chiseled

+ Water currents only push boats with a driver, so you could unequip the paddle (a boat with someone in it will be affected by water current regardless of paddle)
+ Animals could be mounted through fences (fences made thicker, interaction distance made shorter)
+ Bearer's Flag doesn't color properly
+ Plate Helmet Plume with Visor turns invisible when recolored (simple fix)
+ Can't build on bridges

"}