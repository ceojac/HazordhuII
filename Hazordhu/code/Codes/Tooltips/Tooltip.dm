

/*
Koil wrote all of this, and said I can release it, since it did not seem like he was going to.
I did, however, turn the CSS into an argument, just in case someone wanted to specify it =P

This contains all of the original documentation.
*/
proc/tooltip(
			client/c = null,
			id = "",
			content = "",
			size_x = 256,
			size_y = 14,
			pos_x = 0,
			pos_y = 0,
			timeout = -1,
			fadeout = FALSE,
			focus_window = "main_window",
			css = {"
				font-family: "Default";
				font-size: 14px;
				background-color: #8C7839;
				border: 1px solid #000000;
				margin: 0px;
				padding: 0px;
				padding-left: 3px;
				width: [size_x]px;
				height: [size_y]px;
			"}
			)
	/*
	c = who to display the tooltip to (needs to be a client or a mob)
	id = an id to give the tooltip. reusing an id will reuse an existing tooltip,

	size_x, size_y = the size of the tooltip (in pixels)
	pos_x, pos_y = the position of the tooltip (pixels, screen coordinates)

	timeout = the amount of time (in ticks) to wait before the tooltip is to disappear (-1 for no timeout, default = -1)
	fadeout = whether or not to fade the window out, or make it disappear instantly after timeout (default setting = FALSE)

	focus_window = the main window control to give focus back to after displaying tooltips (default setting = default)
	*/

	spawn
		if(c && id && content && pos_x && pos_y)
			id = "_[id]_tooltip"

			if(size_y < 14) size_y = 14

			if(pos_x < 0) pos_x = 0
			if(pos_y < 0) pos_y = 0

			var/browser_id = "[id]_browser"

			if(!winexists(c, id))
				winclone(c, "window", id)

			winset(c, id, "statusbar=false;\
							can-close=false;\
							can-resize=false;\
							can-minimize=false;\
							can-scroll=false;\
							titlebar=false;\
							size=[size_x],[size_y];\
							pos=[pos_x],[pos_y];\
							focus=false;\
							alpha=255")

			if(!winexists(c, browser_id))
				winset(c, browser_id, "parent=[id];\
					type=browser;\
					pos=0,0;\
					size=[size_x + 17],[size_y + 17];\
					anchor1=0,100;\
					anchor2=100,0;\
					focus=false;")

			var/tooltip_page =\
			{"
	<html>
		<head>
			<style type="text/css">
				BODY {
					margin: 0px;
					padding: 0px;
					overflow: none;
				}

				div#content {
					[css]
				}
			</style>
		</head>
		<body>
			<div id="content">
				[content]
			</div>
		</body>
	</html>
		"}

			c << output(tooltip_page, "[id].[browser_id]")
			winshow(c, id, 1)

			if(winexists(c, focus_window)) winset(c, focus_window, "focus=true")

			if(timeout != -1)
				sleep(timeout)
				if(fadeout)
					var/alpha = 255
					while(alpha > 0)
						winset(c, id, "alpha=[alpha]")
						alpha -= 20

						sleep(1)

				winshow(c, id, FALSE)
				c.uid --