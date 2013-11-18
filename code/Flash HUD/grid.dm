hud/grid
	//	who this HUD is shown to
	var client/client

	//	in cells
	var width = 4
	var height = 5

	//	in pixels
	var cell_width = 32
	var cell_height = 32

	//	a list of cells
	var cells[]

	//	anchor position, origin of growth
	var x = "WEST"
	var y = "SOUTH"

	var px = 0
	var py = 0

	var horizontal_padding = 0
	var vertical_padding = 0

	//	direction of growth
	var dir = NORTHEAST

	//	show/hide stuff
	var _visible = false
	proc/show() if(!_visible)
		_visible = true
		client.screen |= cells
		return true

	proc/hide() if(_visible)
		_visible = false
		client.screen -= cells
		return true

	proc/toggle() _visible ? hide() : show()

	proc/is_visible() return _visible

	//	mouse interactions (usr-friendly)
	proc/mouse_down(hud/grid/cell/cell)
	proc/click(hud/grid/cell/cell)
	proc/right_click(hud/grid/cell/cell)
	proc/mouse_up(hud/grid/cell/cell)

	proc/drag(hud/grid/cell/cell, atom/over_object)
	proc/drop(hud/grid/cell/cell, atom/over_object)

	//	handy events
	proc/add_cell(hud/grid/cell, x, y)
	proc/filled(hud/grid/cell)
	proc/emptied(hud/grid/cell)

	//	initialize and populate cells
	New(client/client)
		src.client = client
		cells = new
		for(var/y in height to 1 step -1) for(var/x in 1 to width)
			var dx = 0, dy = 0
			if(dir & NORTH) dy = y - 1
			if(dir & SOUTH) dy = 1 - y
			if(dir & EAST)  dx = x - 1
			if(dir & WEST)  dx = 1 - x
			var hud/grid/cell/c = new
			var sx = "[src.x]:[src.px + dx * cell_width + (x - 1) * horizontal_padding]"
			var sy = "[src.y]:[src.py + dy * cell_height + (y - 1) * vertical_padding]"
			c.screen_loc = "[sx],[sy]"
			c.grid = src
			cells += c
			add_cell(c, x, y)

	cell
		parent_type = /obj
		icon = 'code/flash hud/hud icons 32.dmi'
		icon_state = "cell"
		layer = 200
		var atom/object
		var hud/grid/grid
		var id
		Click(l, c, p[])
			p = params2list(p)
			if(p["left"]) grid.click(src)
			if(p["right"]) grid.right_click(src)
		MouseDrag(o) grid.drag(src, o)
		MouseDrop(o) grid.drop(src, o)
		MouseDown() grid.mouse_down(src)
		MouseUp() grid.mouse_up(src)

		proc/empty()
			object = null
			overlays = list()
			name = "cell"
			grid.emptied(src)

		proc/fill(atom/o)
			if(!o)
				empty()

			else
				object = o
				name = o.name

				var image/i = image(o.icon, o.icon_state, layer = 201)
				i.pixel_x = o.pixel_x
				i.pixel_y = o.pixel_y
				overlays = list(i) + o.overlays
				grid.filled(src)

		proc/swap(hud/grid/cell/cell)
			var atom/a = object
			var atom/b = cell.object
			empty()
			cell.empty()
			if(b) fill(b)
			if(a) cell.fill(a)

	inventory
		x = 1
		y = 2

		show()
			. = ..()
			if(.)
				var mob/player/p = client.mob
				if(p.storage)
					p.storage_grid.show()

		hide()
			. = ..()
			if(.)
				var mob/player/p = client.mob
				p.stop_storage()

		emptied(hud/grid/cell/cell)
			cell.name = "inventory"

		drop(hud/grid/cell/a, hud/grid/cell/b)
			var mob/player/p = usr

			//	swap cells
			if(b in cells)
				var obj/Item/A = a.object
				var obj/Item/B = b.object
				if(A && B) A.MouseDrop(B)
			//	a.swap(b)

			//	equip
			else if(b in p.equipment_grid.cells)
				p.equip(a.object)

			//	store
			else if(b in p.storage_grid.cells)
				if(a.object)
					var obj/Item/i = a.object
					i.store_item(p, p.has_key("ctrl") || p.client.mouse.right)
					b.fill(i)

			//	other
			else a.object.MouseDrop(b, usr, b.loc)

		//	drop
		click(hud/grid/cell/cell)
			var obj/Item/item = cell.object
			if(istype(item))
				item.interact(client.mob)
			cell.fill(cell.object)

		//	interact
		right_click(hud/grid/cell/cell)
			var obj/Item/item = cell.object
			if(istype(item))
				//	alternate use
				if(client.has_key("ctrl"))
					item.use_alt(client.mob)

				//	normal use
				else item.use(client.mob)

	storage
		x = 6
		y = 3

		emptied(hud/grid/cell/cell)
			cell.name = "storage"

		drop(hud/grid/cell/a, hud/grid/cell/b)
			var mob/player/p = client.mob
			var obj/Item/i = a.object
			if(b in cells)
				a.swap(b)
			else if(i)
				if(b in p.inventory_grid.cells)
					i.unstore_item(p, p.has_key("ctrl") || p.client.mouse.right)
					b.fill(i)
				else if(b in p.equipment_grid.cells)
					i.unstore_item(p, p.has_key("ctrl") || p.client.mouse.right)
					p.equip(i)

		show()
			. = ..()
			var mob/player/p = client.mob
			if(. && p.crafting_button.expanded)
				p.crafting_grid.hide()

		hide()
			. = ..()
			var mob/player/p = client.mob
			if(. && p.crafting_button.expanded)
				p.crafting_grid.show()

	equipment
		x = 1
		y = 8
		px = 16
		py = -16
		width = 3
		height = 4

		//	unequip
		drop(hud/grid/cell/a, hud/grid/cell/b)
			var mob/player/p = usr
			if(a.object && (b in p.inventory_grid.cells) && p.unequip(a.object) && !b.object)
				b.fill(a.object)

		click(hud/grid/cell/cell)
			var mob/player/p = usr
			if(cell.object)
				p.unequip(cell.object)

		//	interact
		right_click(hud/grid/cell/cell)
			var obj/Item/item = cell.object
			if(istype(item))
				//	alternate use
				if(client.has_key("ctrl"))
					item.use_alt(client.mob)

				//	normal use
				else item.use(client.mob)

		//	specified slots
		var global/equipment_slots[] = list(
			"1,1" = "misc",
			"2,1" = "feet",
			"3,1" = "bag",
			"1,2" = "belt",
			"2,2" = "legs",
			"3,2" = "hands",
			"1,3" = "main",
			"2,3" = "body",
			"3,3" = "off",
			"1,4" = "helmet",
			"2,4" = "head",
			"3,4" = "back")

		add_cell(hud/grid/cell/cell, x, y)
			cell.id = equipment_slots["[x],[y]"]

		filled(hud/grid/cell/cell)
			cell.icon_state = "cell"

		emptied(hud/grid/cell/cell)
			cell.icon_state = cell.id
			cell.name = "equipment"

	crafting
		x = 6
		y = 3
		px = -18
		py = -16
		width = 2
		height = 3
		horizontal_padding = 226
		vertical_padding = 66

		var index
		var craftables[]

		var hud/grid/crafting/arrow
			next/next
			previous/previous

		New()
			..()
			next = new (src)
			previous = new (src)

		show() if(craftables)
			. = ..()
			if(.)
				client.screen |= list(next, previous)
				var mob/player/p = client.mob
				p.storage_grid.hide()

		hide()
			. = ..()
			if(.)
				client.screen -= list(next, previous)
				var mob/player/p = client.mob
				if(p.storage) p.storage_grid.show()

		arrow
			parent_type = /obj
			icon = 'code/flash hud/hud icons 32.dmi'
			var hud/grid/crafting/grid
			New(g) grid = g

			next
				icon_state = "next"
				screen_loc = "22:-16,10:19"
				layer = 200
				Click()
					var a = grid.width * grid.height
					var i = grid.index + a
					if(i >= grid.craftables.len) i = 0
					grid.index = i

					var mob/player/p = usr
					p.fill_crafting_grid(grid.craftables, grid.index)

			previous
				icon_state = "previous"
				screen_loc = "5:14,10:19"
				layer = 200
				Click()
					var a = grid.width * grid.height
					var i = grid.index - a
					if(i < 0) i = round(grid.craftables.len - a / 2, a)
					grid.index = i

					var mob/player/p = usr
					p.fill_crafting_grid(grid.craftables, grid.index)

		drag(hud/grid/cell/cell)
			if(cell.object)
				var mob/player/p = client.mob
				p.BuildGrid.show()
				p.crafting_grid.hide()

		drop(hud/grid/cell/cell, BuildGrid/build_cell/build_cell)
			if(cell.object)
				var mob/player/p = client.mob
				var builder/b = cell.object
				if(istype(build_cell) && istype(b))
					build_cell.parent.select(build_cell)
					b.craft(p)
				p.BuildGrid.hide()
				if(p.crafting_button.expanded)
					p.crafting_grid.show()

		var obj/bg
		New()
			..()
			bg = new
			bg.icon = 'code/flash hud/hud icons 32.dmi'
			bg.icon_state = "bg"
			bg.layer = 199
			bg.screen_loc = "5,1 to 23,10"
			bg.name = "crafting"

		show()
			. = ..()
	//		if(.) client.screen |= bg

		hide()
			. = ..()
	//		if(.) client.screen -= bg

		var labels[]
		New()
			..()
			labels = new
			for(var/y in height to 1 step -1) for(var/x in 1 to width)
				var hud/grid/crafting/label/c = new
				var dx = 0, dy = 0
				if(dir & NORTH) dy = y - 1
				if(dir & SOUTH) dy = 1 - y
				if(dir & EAST)  dx = x - 1
				if(dir & WEST)  dx = 1 - x
				var sx = "[src.x]+1:[src.px + dx * cell_width + (x - 1) * horizontal_padding]"
				var sy = "[src.y]-1:[src.py + dy * cell_height + (y - 1) * vertical_padding]"
				c.screen_loc = "[sx],[sy]"
				c.grid = src
				labels += c

		show()
			. = ..()
			if(.) client.screen |= labels

		hide()
			. = ..()
			if(.) client.screen -= labels

		label
			parent_type = /hud/grid/cell
			icon = 'code/flash hud/hud icons medium.dmi'
			maptext_width = 224
			maptext_height = 96
			proc/set_text(t) maptext = "<font size=2 align=left valign=top>[t]"

		filled(hud/grid/cell/cell)
			var hud/grid/crafting/label/label = labels[cells.Find(cell)]
			var builder/builder = cell.object
			label.set_text(replaceall("<b>[builder.name]</b>: [builder.desc]", "<br />", "\n"))

		emptied(hud/grid/cell/cell)
			var hud/grid/crafting/label/label = labels[cells.Find(cell)]
			label.set_text()