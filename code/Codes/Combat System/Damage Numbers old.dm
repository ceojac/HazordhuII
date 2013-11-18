
#ifndef DAMAGE_ICON
#define DAMAGE_ICON 'nums.dmi'
#endif

obj/damage_num
	layer=99
	name=""
	icon_state=""

datum/proc/Displaydam(ref,num,color) // The color should be to string, but is pre-defined by the color parameter I used below.
	/*
	Take note of the three parameters: ref, num, and color. ref is the reference point that
	the numbers will magically pop out of. num is the number which will pop up. Last but not
	least, color is the color of the numbers that pop up. They can be set to blue for healing,
	green for poison, red for normal wounds, black for orgasm damage, whatever you want.

	An example: Displaydam(f0lak (/mob),69,"#00000")
	That would display the numbers 69 on YOU. Oh, and the numbers would be nigger-colored.
	*/
	var/icon=DAMAGE_ICON
	icon+=color

	num=round(num,1) // We don't really want decimals.

	if(num>9999) num=9999 // To prevent some nasty bugs from screwing up the icons.. even though I doubt numbers would reach THIS high.
	if(num<1) num=0 // The damage system can't render negative numbers, so the next best thing is zero.

	var/string=num2text(num) // Converts the input number(s) into a string for lentext() to run through it.
	var/first_char
	var/second_char
	var/third_char
	var/fourth_char
	var/obj/damage_num/first
	var/obj/damage_num/second
	var/obj/damage_num/third
	var/obj/damage_num/fourth

	if(lentext(string)==1) // This checks to see if the string is one digit long.
		first_char=copytext(string,1,2)
		first=new
	if(lentext(string)==2) // This checks to see if the string is TWO digits long.
		second_char=copytext(string,1,2)
		second=new
		first_char=copytext(string,2,3)
		first=new
	if(lentext(string)==3) // So on.
		third_char=copytext(string,1,2)
		third=new
		second_char=copytext(string,2,3)
		second=new
		first_char=copytext(string,3,4)
		first=new
	if(lentext(string)==4)
		fourth_char=copytext(string,1,2)
		fourth=new
		third_char=copytext(string,2,3)
		third=new
		second_char=copytext(string,3,4)
		second =new
		first_char=copytext(string,4,5)
		first=new

	var/target=ref
	if(ismob(ref)||isobj(ref)) target = ref:loc // The target can be either an object or a mob.

	if(first)  first.loc=target // When the first, second, third and are created they are given a location: target.
	if(second) second.loc=target
	if(third)  third.loc=target
	if(fourth) fourth.loc=target

	if(first)
		first.icon=icon
		flick("---[first_char]",first) // The reason the icon_states are like this is because it spaces it to make room for more nigga shiz. That's Duel talk for more, "making space for digits to be placed in with the other digits"
	if(second)
		second.icon=icon
		flick("--[second_char]-",second)
	if(third)
		third.icon=icon
		flick("-[third_char]--",third)
	if(fourth)
		fourth.icon=icon
		flick("[fourth_char]---",fourth)

	spawn(10) // After the party, they all pack their shit and gtfo.
		if(first)  del(first) // That means you.
		if(second) del(second) // And you.
		if(third)  del(third) // Can't forget you.
		if(fourth) del(fourth) // Slept with your mom