/*

This file contains a demonstration of how the Tooltip system can be employed.
This may or may not be the best way to do it, and is most likely very inefficient.
It does, however, serve it's demonstrative purpose.

*/

// the delay between mousing in, and when the tooltip is shown
#define TOOLTIP_DELAY 4

// the box around where the mouse enters the atom, which will still let the tooltip show
// this is a 5x5 box, centered around the point where HasMouseEntered() is called
#define TOOLTIP_BOX_SIZE 5

// check whether or not the mouse is in it's grace-range for the tooltip to appear
#define in_range(x, y) (x > y-TOOLTIP_BOX_SIZE && x < y+TOOLTIP_BOX_SIZE)


/**#client
 *  client.mouse_x
 *  client.mouse_y
 *  client.uid
 *  client.MouseEntered()
 *  client.update_mouse()
 *  client.Topic()
 */
client
	var
		// the x position (from the top left) of the mouse
		mouse_x

		// the y position (from the top left) of the mouse
		mouse_y

		// a unique number for this client
		uid = 0

	proc

		// get the new mouse coordinates, and send them to Topic()
		update_mouse()
			src << output({"
				<html>
					<head>
						<script type="text/javascript">
							function coordinate(event) {
								window.location="?action=mousecoord&x="+event.screenX+"&y="+event.screenY
							}
						</script>
					</head>

					<body onload="coordinate(event)"></body>
				</html>
			"},"#tooltip.browser")
			// #modification_interface

	// just for intercepting the above javascript
	Topic(href, hlist[], hsrc)

		. = ..()

		switch(hlist["action"])

			if("mousecoord")
				mouse_x = text2num(hlist["x"])
				mouse_y = text2num(hlist["y"])

	// this is probably a very inefficient way to do it, but it is just a demonstration
//	MouseEntered(atom/object, location, control, params)

//		if(object.hasTooltip)

			// we have to update the mouse coordinates before we spawn a tooltip
//			update_mouse()

			//give the user some time to get his/her mouse inside the item and pause it
//			sleep(TOOLTIP_DELAY/2)

//			object.HasMouseEntered(src, location, control, params)

/**#atom
 *  atom.hasTooltip
 *  atom.tooltipRows
 *  atom.HasMouseEntered()
 */
atom

	//icon = 'stuff.dmi'

	var
		// this is just one way it can be done
		hasTooltip	= 0

		// since the tooltip supports CSS, it's a bit harder to *always* know how big it should be
		// this is the way I got around that, even though it's more lazy than it should be
		tooltipRows	= 2

	proc/show_tooltip(mob/m)
		if(hasTooltip)
			m.client.update_mouse()
			spawn(3)
				var/client/c = m.client
				var cuid = c.uid + 1
				c.uid ++
				winshow(c, "_[cuid]_tooltip", FALSE)
				tooltip(c, "[cuid]", "[desc]", 256, 17*tooltipRows, c.mouse_x, c.mouse_y, 30, TRUE)