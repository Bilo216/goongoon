/mob/living/critter/small_animal/pig
	name = "space pig"
	real_name = "space pig"
	desc = "A pig. In space."
	icon_state = "pig"
	icon_state_dead = "pig-dead"
	density = TRUE
	speechverb_say = "oinks"
	speechverb_exclaim = "squeals"
	meat_type = /obj/item/reagent_containers/food/snacks/ingredient/meat/bacon
	name_the_meat = FALSE

	ai_type = /datum/aiHolder/pig // Worry not they will only attack mice
	ai_retaliate_persistence = RETALIATE_UNTIL_INCAP

	setup_hands()
		..()
		var/datum/handHolder/HH = hands[1]
		HH.limb = new /datum/limb/mouth/small
		HH.icon = 'icons/mob/critter_ui.dmi'
		HH.icon_state = "mouth"
		HH.name = "mouth"
		HH.limb_name = "teeth"
		HH.can_hold_items = 0

	specific_emotes(var/act, var/param = null, var/voluntary = 0)
		switch (act)
			if ("scream")
				if (src.emote_check(voluntary, 50))
					return SPAN_EMOTE("<b>[src]</b> squeals!")
		return null

	specific_emote_type(var/act)
		switch (act)
			if ("scream")
				return 2
		return ..()

	on_pet(mob/user)
		if (..())
			return 1
		if (prob(10))
			src.audible_message("[src] purrs![prob(20) ? " Wait, what?" : null]",\
			"You purr!")

	valid_target(mob/living/C)
		if (isintangible(C)) return FALSE
		if (isdead(C)) return FALSE
		if (src.faction)
			if (C.faction & src.faction) return FALSE
		if (istype(C, /mob/living/critter/small_animal/mouse)) return TRUE

	death(var/gibbed)
		if (!gibbed)
			src.reagents.add_reagent("beff", 50, null)
		return ..()
