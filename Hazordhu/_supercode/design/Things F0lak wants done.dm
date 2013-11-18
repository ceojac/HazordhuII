/*

Here is a list of things that I'd like done.  When it's finished delete it from this list.
If you have any questions contact me online or on my cell 780 700 4732


A lot of this stuff is revamps and improvements on existing systems on both the backend and frontend to make the game
look and perform better as well as make it easier to work on for us.  It's a lot of work, but with four programmers,
three pixel artists, and a musician this shouldn't take too too much time and effort.

I'd love if we could get all of this done in one fell swoop, but that's unrealistic.  What's going to end up happening
is that we'll tackle this little by little, which will result in some wipes here and there, but let's not bite off more
than we can chew.  I'd like to hold off on new features while we work on adding on this polish, which will make things
a lot easier for us all in the long run by making the source compile faster, and the game perform and look better, thereby
improving the experience for players.


THE LIST
	- Animations for all of the items.  (lol)

	GUI
		I'd like for this to eventually become entirely done via screen objects, thus removing the clunky interface elements
		that BYOND uses.  This will give us more control over making the game elements look better, and they (should) provide
		us with more speed in some commands.

		We can start by making the stat bars display on the map.  What I'd like to do is remove the (ugly) bars altogether and
		instead replace them with a pop-up on the map that displays when you get hungry or thirsty.  To those of you who saw my
		GUI design for H3 this will look familiar.  To those who didn't, this will look off at first but I'll try to dig up my
		diagram for comparrison later.

		Here's my vision of the GUI (a key will follow)
		(it's not to scale)

		.-------------------------------------------.
		|<3<3<3										|
		|				  OOOOO  					|
		|											|
		|											|
		|											|
		|				  chat!						|
		|					P						|
		|											|
		|											|
		|---------x|								|
		|		   |								|
		|		   |							x  x|
		|		   |							x  X|
		'-------------------------------------------'

		OOOOO	- Stamina, Hunger, Thirst, Bleeding, and Temperature popups
		P		- Player
		<3		- Health Hearts (or whatever graphic we choose)
		chat!	- Chat text and emotes will appear above the player
		X's		- these will be graphics for basic GUI buttons:
				  The big X is for the menu while the others are for Inventory, Skills, and a toggle for OOC chat
		The box in the lower left is for OOC and a chat log.

		Other interface elements will pop up, and be snapped to the top right of the map (inventory, skills, menu, etc)

	Map Save
		This needs discussion.  I don't see the point in making it as fast and efficient as possible to load, but the saving needs
		to be revisited and not use areas. (I'm pretty sure I can make lighting work through use of areas instead of images).
		There are a few ideas I have.

			Rather than saving areas, save types.  Every object has a save id and a reference to that object
			is stored in a datum.  When it comes time to save we loop through all of those objects with that save ID.  Hell, to make this
			quicker we could add a check wherein if a list is too large (1,000 entries?) it creates a new list on the datum to save those
			new objects under.  This way we can save things on the fly quickly by saving a list at a time every minute or so.  Different types
			would have different ID's (ie: Wooden walls and floors would be ID1, Stone walls and floors ID2, furniture ID3, etc)

			We could save objects on the fly like Tekken tried to do.  It would be kinky in the beginning, but would work out eventually.

			The third idea is my favorite, and requires us to wait until I'm done other signifcant gameplay changes before we can implement.
			Now that I think about it, we'll probably use this idea eventually anyways:  Saving each scene when it's unloaded (no more players
			present in it(See New Map Stuff)).


	New Map Stuff (See New Map Stuff.dm)
*/