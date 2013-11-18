//	2D vector implementation.
/*
	List of stuff

		v and u are vectors
		s and d are scalars
		a and b are coordinates (technically vectors)
		All operations return a new vector object

			Vectors are /lists
			e.g.
				var v[] = vec2(x, y)
				v[1] == x
				v[2] == y

			/proc
				is_vec2(v)
				vec2_print(v)
				vec2_cmp(v, u)
				vec2_copy(v)
				vec2_iszero(v)
				vec2_nonzero(v)
				vec2_add(v, u)
				vec2_sub(v, u)
				vec2_scale(v, s)
				vec2_divide(v, d)
				vec2_neg(v)
				vec2_mag(v)
				vec2_mag2(v)
				vec2_angle(v)
				vec2_unit(v)
				vec2_dot(v, u)
				pos2_dist(a, b)
*/

#define vec2(x, y) list(x, y)
#define vec2p(r, t) vec2(r * sin(t), r * cos(t))

//	A shortcut for vec2(0, 0), which is the zero vector.
//	Handy for when you want to initialize a vector.
#define vec2_zero	vec2(0, 0)

//	Shortcuts for unit vectors along each axis in both directions.
#define vec2_i		vec2(1, 0)
#define vec2_j		vec2(0, 1)
#define vec2_ni		vec2(-1, 0)
#define vec2_nj		vec2(0, -1)


proc/is_vec2(v[])			return istype(v) && v.len == 2
proc/vec2_copy(v[])			return v.Copy()
proc/vec2_cmp(v[], u[])		return v == u || v[1] == u[1] && v[2] == u[2]
proc/vec2_add(v[], u[])		return vec2(v[1] + u[1], v[2] + u[2])
proc/vec2_sub(v[], u[])		return vec2(v[1] - u[1], v[2] - u[2])
#define vec2_to(v, u)		vec2_sub(u, v)
proc/vec2_scale(v[], s)		return vec2(s * v[1], s * v[2])
proc/vec2_divide(v[], d)	return vec2(v[1] / d, v[2] / d)
proc/vec2_neg(v[])			return vec2(-v[1], -v[2])
#define vec2_mag2(v)		vec2_dot(v, v)
#define vec2_mag(v)			sqrt(vec2_mag2(v))
proc/vec2_dot(v[], u[])		return v[1] * u[1] + v[2] * u[2]
#define vec2_angle(v)		_vec2_atan2(v)
proc/vec2_unit(v[])			return vec2_divide(v, vec2_mag(v))
proc/vec2_iszero(v[])		return !v || !v[1] && !v[2]
#define vec2_nonzero(v)		!vec2_iszero(v)
proc/vec2_setmag(v[], m)	return vec2_scale(vec2_unit(v), m)


proc
	/**
	 * Convert a vector to text.
	 * Because definitions can't support optional parameters,
	 *  and this is pretty customizable.
	 *
	 * @param	v to be converted to formatted text
	 * @param	separator goes between the components, followed by a space
	 * @param	prefix goes before the sequence of components
	 * @param	suffix goes after the sequence of components
	 * @return	the vector converted to a nice string
	 * 			e.g.	vec2_print(vec2(1, 2))
	 * 					=> "<1, 2>"
	 * 					vec2_print(vec2(3, 4), "{", "}")
	 * 					=> "{1, 2}"
	 */
	vec2_print(v[], prefix = "<", suffix = ">", separator = ",")
		return "[prefix][v[1]][separator] [v[2]][suffix]"

	/**
	 * Get the angle of a vector
	 *
	 * @param	x the x-component of a vector with magnitude
	 * 			The vector itself can also be given.
	 * @param	y if a vector wasn't passed to x, this is the y-component
	 * @return	the angle of the vector given as x or described by x and y
	 */
	_vec2_atan2(x, y)
		if(is_vec2(x))
			y = x[2]
			x = x[1]
		return atan2(x, y)

	/**
	 * Get the distance between two points
	 *
	 * @param	a a point
	 * @param	b another point
	 * @return	the distance between the two points
	 * 			order doesn't matter
	 */
	pos2_dist(a[], b[])
		var r[] = vec2_to(a, b)
		return vec2_mag(r)
/*

	ALIASES

*/
#define vec2_polar(r, t) vec2p(r, t)
#define isvec2(v) is_vec2(v)
#define vec2_is_zero(v) vec2_iszero(v)
#define vec2_non_zero(v) vec2_nonzero(v)
#define vec2_subtract(v, u) vec2_sub(v, u)
#define vec2_magnitude(v) vec2_mag(v)
#define vec2_length(v) vec2_mag(v)
#define vec2_len(v) vec2_mag(v)
#define vec2_multiply(v, s) vec2_scale(v, s)
#define vec2_reverse(v) vec2_neg(v)
#define vec2_compare(v, u) vec2_cmp(v, u)
#define vec2_equals(v, u) vec2_cmp(v, u)