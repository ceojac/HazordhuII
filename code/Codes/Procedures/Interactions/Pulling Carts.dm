
mob/proc	//	Carts
	is_cart(obj/Built/o)
		if(istype(o, /obj/Built/Storage/Cart)) return 1
		return 0

mob
	var tmp/obj/Built/Storage/Cart/pulling_cart
	Del()
		if(pulling_cart)
			pulling_cart.Puller = null
		..()


mob/proc
	//	Pulling carts
	stop_pulling_cart()
		if(!pulling_cart) return
		pulling_cart.Puller = null
		pulling_cart = null
		emote("stops pulling the cart")

	start_pulling_cart(obj/Built/Storage/Cart/cart)
		pulling_cart = cart

		var mob/player/p = src
		if(istype(p))
			pulling_cart.Puller = p.charID

		emote("starts pulling the cart")

	_pull_cart(obj/Built/Storage/Cart/cart)
		if(!is_cart(cart)) return

		if(pulling_cart == cart)
			stop_pulling_cart()
			return 1

		if(cart.Puller)
			aux_output("Someone else is pulling this cart.")
			return

		else
			if(pulling_cart)
				stop_pulling_cart()

			start_pulling_cart(cart)
			return 1