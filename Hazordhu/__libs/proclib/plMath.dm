/*

	Kaiochao's ProcLib - Icons

	List o' Functions
		text2dim	=>	Converts text to a 2D list of numbers. ( e.g. "AxB" => list(A, B) )
		sign		=>	1 if positive, -1 if negative, 0 if 0.
		clamp		=>	The number 'a' within 'b' and 'c'
		lerp		=>	A number c% of the way from a to b.
		randn		=>	A random number between a and b. (Not just integers!)
		distance	=>	The distance formula.
						Distance between points a and b:
							distance(ax, ay, bx, by)
							distance(list(ax, ay), list(bx, by))
						Length of a vector:
							distance(x, y)
							distance(list(x, y))
*/
proc
	//	converts "#,#" or "#x#" to list(#, #)
	text2dim(t, separator = "x")
		. = split(t, separator)
		.[1] = text2num(.[1])
		.[2] = text2num(.[2])

	//	-1 if negative, 1 if positive (or 0)
	sign(n) return n && n / abs(n)

	//	keep a number a within bounds [b c]
	clamp(a, b, c) return min(max(a, b), c)

	//	returns c% of the way from a to b
	lerp(a, b, c) return a * (1 - c) + b * c

	//	because rand(lower, upper) only works with integers
	randn(lower, upper) return lerp(lower, upper, rand())

	distance()
		//	accepts 2 coordinate pairs as
		//		4 numbers
		//		2 vectors (dot product)
		//		1 vector (magnitude)
		if(!(args && args.len)) return

		if(args.len == 4)
			var dx = args[3] - args[1]
			var dy = args[4] - args[2]
			return sqrt(dx * dx + dy * dy)

		else if(args.len == 2)
			if(isnum(args[1])  && isnum(args[2]))
				return sqrt(args[1] * args[1] + args[2] * args[2])

			else
				var a[] = args[1]
				var b[] = args[2]
				if(istype(a) && istype(b) && a.len == b.len)
					if(a.len == 2)
						var dx = b[1] - a[1]
						var dy = b[2] - a[2]
						return sqrt(dx * dx + dy * dy)

					else if(a.len == 3)
						var dx = b[1] - a[1]
						var dy = b[2] - a[2]
						var dz = b[3] - a[3]
						return sqrt(dx * dx + dy * dy + dz * dz)

		else if(args.len == 1)
			var v[] = args[1]
			if(istype(v))
				if(v.len == 2)
					return sqrt(v[1] * v[1] + v[2] * v[2])
				else if(v.len == 3)
					return sqrt(v[1] * v[1] + v[2] * v[2] + v[3] * v[3])