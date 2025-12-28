SCUG = SMODS.current_mod

assert(SMODS.load_file("./lib.lua"))()
assert(SMODS.load_file("./modules/atlas.lua"))()
assert(SMODS.load_file("./modules/foods.lua"))()
assert(SMODS.load_file("./modules/jokers.lua"))()
assert(SMODS.load_file("./modules/challenges.lua"))()
assert(SMODS.load_file("./modules/booster.lua"))()
assert(SMODS.load_file("./modules/deck.lua"))()
assert(SMODS.load_file("./modules/food_rarities.lua"))()
assert(SMODS.load_file("./modules/weapons.lua"))()
assert(SMODS.load_file("./modules/vouchers.lua"))()
assert(SMODS.load_file("./modules/blinds.lua"))()
if SCUG.config.allow_enemy_spawns then
	assert(SMODS.load_file("./modules/enemies.lua"))()
end
assert(SMODS.load_file("./modules/enhancement.lua"))()
assert(SMODS.load_file("./modules/stickers.lua"))()
assert(SMODS.load_file("./modules/tags.lua"))()
assert(SMODS.load_file("./modules/achievements.lua"))()
--assert(SMODS.load_file("./modules/debug.lua"))()

--Debug allows for the use of the Rot fruit for testing rot! Wet fruit as well for wet cards!

local wet_keys = {
	"j_splash",
	"j_seltzer",
	"j_dietcola",
	"j_rw_rivulet",
	"j_rw_stupid_wet_rat",
}

SMODS.Sound({
	key = "crunch",
	path = {
		["default"] = "crunch.mp3",
	},
})

-- Patches for Game Functions

-- local game_igo = Game.init_game_object
-- function Game:init_game_object()
-- 	local ret = game_igo(self)
-- 	ret.rottedjoker = 5
-- 	ret.mirosbird = 1
-- 	ret.mirosvulture = 1
-- 	ret.rw_enemies_slain = 0
-- 	ret.rw_achievement_stats = {
-- 		scug_antes = 0,
-- 		ante_kills = {}
-- 	}
-- 	return ret
-- end

SCUG.reset_game_globals = function(run_start)
	if run_start then
		G.GAME.rottedjoker = 5
		G.GAME.mirosbird = 1
		G.GAME.mirosvulture = 1
		G.GAME.rw_enemies_slain = 0
		G.GAME.rw_achievement_stats = {
			scug_antes = 0,
			ante_kills = {}
		}
	end
end

local end_round_ref = end_round
function end_round()
	end_round_ref()
	for k, x in pairs(G.deck.cards) do
		if (x.config.center == G.P_CENTERS.m_rw_wetasscard or x.config.center == G.P_CENTERS.m_rw_moldy) and not x.debuff then
			local enhanced = {}
			enhanced[#enhanced + 1] = x
			if G.GAME.selected_back.effect.center.key == "b_rw_LTTMdeck" or next(SMODS.find_card("j_rw_rivulet")) or next(SMODS.find_card("j_splash")) or next(SMODS.find_card("j_diet_cola")) or next(SMODS.find_card("j_seltzer")) then
				x.ability.countdown_to_dry = x.ability.countdown_to_dry + 1
				--[[Add check here if a joker is wet to increase rather than decrease]]
			else
				x.ability.countdown_to_dry = x.ability.countdown_to_dry - 1
			end
			--Drying part of function
			local z = {}
			for i = 1, #G.deck.cards do
				if
					G.deck.cards[i].config.center == G.P_CENTERS.m_rw_wetasscard
					and G.deck.cards[i].ability.countdown_to_dry < 1
				then
					z = G.deck.cards[i]
					z:set_ability(G.P_CENTERS.c_base)
					--z.config.center = G.P_CENTERS.c_base
				elseif G.deck.cards[i].config.center == G.P_CENTERS.m_rw_moldy
					and G.deck.cards[i].ability.countdown_to_dry < 6 then
					z = G.deck.cards[i]
					z:set_ability(G.P_CENTERS.m_rw_wetasscard)
				elseif G.deck.cards[i].config.center == G.P_CENTERS.m_rw_wetasscard
					and G.deck.cards[i].ability.countdown_to_dry >= 9 and G.deck.cards[i].ability.countdown_to_dry < 12 then
					z = G.deck.cards[i]
					z:set_ability(G.P_CENTERS.m_rw_moldy)
				elseif G.deck.cards[i].config.center == G.P_CENTERS.m_rw_moldy
					and G.deck.cards[i].ability.countdown_to_dry >= 12 then
					z = G.deck.cards[i]
					z:set_ability(G.P_CENTERS.m_rw_rotting)
				end
			end
		end
	end

	--For cards in the hand at the end of the round;
	for k, x in pairs(G.hand.cards) do
		if (x.config.center == G.P_CENTERS.m_rw_wetasscard or x.config.center == G.P_CENTERS.m_rw_moldy) and not x.debuff then
			local enhanced = {}
			enhanced[#enhanced + 1] = x
			if G.GAME.selected_back.effect.center.key == "b_rw_LTTMdeck" or next(SMODS.find_card("j_rw_rivulet")) or next(SMODS.find_card("j_splash")) or next(SMODS.find_card("j_diet_cola")) or next(SMODS.find_card("j_seltzer")) then
				x.ability.countdown_to_dry = x.ability.countdown_to_dry + 1
				--[[Add check here if a joker is wet to increase rather than decrease]]
			else
				x.ability.countdown_to_dry = x.ability.countdown_to_dry - 1
			end

			--Drying part of function
			local z = {}
			for i = 1, #G.hand.cards do
				if
					G.hand.cards[i].config.center == G.P_CENTERS.m_rw_wetasscard
					and G.hand.cards[i].ability.countdown_to_dry < 1
				then
					z = G.hand.cards[i]
					z:set_ability(G.P_CENTERS.c_base)
					--z.config.center = G.P_CENTERS.c_base
				elseif G.hand.cards[i].config.center == G.P_CENTERS.m_rw_moldy
					and G.hand.cards[i].ability.countdown_to_dry < 6 then
					z = G.hand.cards[i]
					z:set_ability(G.P_CENTERS.m_rw_wetasscard)
				elseif G.hand.cards[i].config.center == G.P_CENTERS.m_rw_wetasscard
					and G.hand.cards[i].ability.countdown_to_dry >= 9 and G.deck.cards[i].ability.countdown_to_dry < 12 then
					z = G.hand.cards[i]
					z:set_ability(G.P_CENTERS.m_rw_moldy)
				elseif G.hand.cards[i].config.center == G.P_CENTERS.m_rw_moldy
					and G.hand.cards[i].ability.countdown_to_dry >= 12 then
					z = G.hand.cards[i]
					z:set_ability(G.P_CENTERS.m_rw_rotting)
				end
			end
		end
	end

	if G.GAME.blind:get_type() == "Boss" then
		for _, v in pairs(G.jokers.cards) do
			if v.ability.slugcat then
				G.GAME.rw_achievement_stats.scug_antes = G.GAME.rw_achievement_stats.scug_antes + 1
				check_for_unlock({ type = "round_win" })
				break
			end
		end
	end
end

local GF_evaluate_play = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play(e)
	GF_evaluate_play(e)

	if G.GAME.blind.config.blind.key == "bl_rw_rotblind" and not G.GAME.blind.disabled then
		local rot = {}
		for i = 1, #G.play.cards do
			if G.play.cards[i].config.center ~= G.P_CENTERS.m_rw_rotting then
				rot = G.play.cards[i]
				--SMODS.calculate_effect({message = 'Rotted!'}, rot)
				rot:set_ability(G.P_CENTERS.m_rw_rotting)
				rot:juice_up()
			end
		end
	end
end

local new_roundref = new_round
function new_round()
	new_roundref()
	-- Joke Rifle's random effect
	local cr = SCUG.number_in_range(1, 11, "rw_wjokerifle")
	if cr <= 5 then
		G.GAME.jokerifle =
			pseudorandom_element({ "bluefruit", "rock", "cherrybomb", "none", "pearl" }, pseudoseed("common"))
	elseif cr > 5 and cr <= 9 then
		G.GAME.jokerifle =
			pseudorandom_element({ "beehive", "flashbang", "grenade", "sporepuff" }, pseudoseed("uncommon"))
	elseif cr > 9 then
		G.GAME.jokerifle = "singularity"
	end

	-- This checks for rotting cards and triggers their countdown + destroys the card if its reached the end of its lifespan

	for _, x in pairs(G.playing_cards) do
		if x.config.center == G.P_CENTERS.m_rw_rotting and not x.debuff then
			-- local enhanced = {}
			-- enhanced[#enhanced + 1] = x
			x.ability.countdown_to_destruction = x.ability.countdown_to_destruction - 1

			if x.ability.countdown_to_destruction == 0 then
				--Destruction part of function
				-- local z = {}
				-- for i = 1, #G.deck.cards do
				-- 	if
				-- 		G.deck.cards[i].config.center == G.P_CENTERS.m_rw_rotting
				-- 		and G.deck.cards[i].ability.countdown_to_destruction < 1
				-- 	then
				-- 		z = G.deck.cards[i]
				-- 		z:start_dissolve()

				-- 		--SMODS.calculate_effect({message = localize('k_upgrade_ex')}, artirot)
				-- 	end
				-- end
				--Artificer's check
				-- if next(SMODS.find_card("j_rw_artificer")) then
				-- 	for i = 1, #SMODS.find_card("j_rw_artificer") do
				-- 		local artirot = SMODS.find_card("j_rw_artificer")[i]
				-- 		artirot.ability.extra.chips = artirot.ability.extra.chips + artirot.ability.extra.bonus_chips
				-- 	end
				-- end
				SMODS.destroy_cards(x)
			else
				-- 1 in 5 chance to make another random card a rot card.
				if SMODS.pseudorandom_probability(nil, "rw_rot", 1, 5, "rw_rot_spread", true) then
					local notrot = {}
					for i = 1, #G.playing_cards do
						if
							G.playing_cards[i] ~= card
							and G.playing_cards[i].config.center ~= G.P_CENTERS.m_rw_rotting
							and not G.playing_cards[i].getting_sliced
						then
							notrot[#notrot + 1] = G.playing_cards[i]
						end
					end
					local rotted = #notrot > 0 and pseudorandom_element(notrot, pseudoseed("explode")) or nil
					if #notrot > 0 then
						rotted:set_ability(G.P_CENTERS.m_rw_rotting)
					end
				end
			end
		end
	end

	-- This checks for joker cards to calculate the rot for
	for i = 1, #G.jokers.cards do
		G.jokers.cards[i]:calculate_rotted()
	end
end

--Definitions for Localization
G.C.FOOD = HEX("0736f3")
G.C.WEAPON = HEX("875796")
G.C.ROT = HEX("000070")

local loc_colour_RW = loc_colour
function loc_colour(_c, _default)
	if not G.ARGS.LOC_COLOURS then
		loc_colour_RW()
	end
	G.ARGS.LOC_COLOURS.weapon = G.C.WEAPON
	G.ARGS.LOC_COLOURS.food = G.C.FOOD
	G.ARGS.LOC_COLOURS.rot = G.C.ROT
	return loc_colour_RW(_c, _default)
end

-- Food Joker Pool (if not defined)
if not SMODS.ObjectTypes["Food"] then
	SMODS.ObjectType({
		key = "Food",
		default = "j_egg",
		cards = {
			["j_popcorn"] = true,
			["j_cavendish"] = true,
			["j_gros_michel"] = true,
			["j_ice_cream"] = true,
			["j_egg"] = true,
			["j_seltzer"] = true,
			["j_flower_pot"] = true,
			["j_ramen"] = true,
			["j_diet_cola"] = true,
			["j_turtle_bean"] = true,
		}
	})
end
