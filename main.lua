SCUG = SMODS.current_mod

assert(SMODS.load_file("./lib.lua"))()
assert(SMODS.load_file("./modules/atlas.lua"))()
assert(SMODS.load_file("./modules/foods.lua"))()
assert(SMODS.load_file("./modules/jokers.lua"))()
assert(SMODS.load_file("./modules/challenges.lua"))()
assert(SMODS.load_file("./modules/booster.lua"))()
assert(SMODS.load_file("./modules/deck.lua"))()
assert(SMODS.load_file("./modules/rarities.lua"))()
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
assert(SMODS.load_file("./modules/stakes.lua"))()
assert(SMODS.load_file("./modules/debug.lua"))()

--Debug allows for the use of the Rot fruit for testing rot! Wet fruit as well for wet cards!

SMODS.Sound({
	key = "crunch",
	path = "crunch.mp3",
})

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
		G.GAME.jokerifle = "none"
	end

	G.GAME.jokerifle = pseudorandom_element(
		{
			"bluefruit",
			"rock",
			"cherrybomb",
			"none",
			"pearl",
			"beehive",
			"flashbang",
			"grenade",
			"sporepuff",
			"singularity",
			"singularity"
		}, "rw_wjokerifle")
end

local end_round_ref = end_round
function end_round()
	end_round_ref()

	local still_wet = SCUG.sufficiently_wet()
	for _, playing_card in pairs(G.playing_cards) do
		local card_type = playing_card.config.center

		if playing_card.ability.countdown_to_dry then
			local dry_mod = still_wet and 1 or -1
			playing_card.ability.countdown_to_dry = playing_card.ability.countdown_to_dry + dry_mod
			local dry_time = playing_card.ability.countdown_to_dry

			if card_type == G.P_CENTERS.m_rw_wetasscard then
				if dry_time < 1 then
					playing_card:set_ability(G.P_CENTERS.c_base)
				elseif dry_time >= 9 then
					playing_card:set_ability(G.P_CENTERS.m_rw_moldy)
				end
			elseif card_type == G.P_CENTERS.m_rw_moldy then
				-- You don't get your wet card back, you molded it already
				if dry_time < 1 then
					playing_card:set_ability(G.P_CENTERS.c_base)
				elseif dry_time >= 12 then
					playing_card:set_ability(G.P_CENTERS.m_rw_rotting)
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

local new_roundref = new_round
function new_round()
	new_roundref()

	for _, x in pairs(G.playing_cards) do
		if x.config.center == G.P_CENTERS.m_rw_rotting and not x.debuff then
			x.ability.countdown_to_destruction = x.ability.countdown_to_destruction - 1

			if x.ability.countdown_to_destruction == 0 then
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
					local rotted = (#notrot > 0) and pseudorandom_element(notrot, pseudoseed("explode")) or nil
					if rotted then
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
loc_colour()
G.ARGS.LOC_COLOURS["weapon"] = G.C.WEAPON
G.ARGS.LOC_COLOURS["food"] = G.C.FOOD
G.ARGS.LOC_COLOURS["rot"] = G.C.ROT

-- Attributes
-- Denotes a Slugcat
SMODS.Attribute {
	key = "slugcat"
}
-- Interacts with Foods (from this mod, not related to default `food` attribute)
SMODS.Attribute {
	key = "rw_food"
}
-- Interacts with Weapons
SMODS.Attribute {
	key = "weapon"
}
-- Affects the Ante (I'm surprised this doesn't already exist?)
SMODS.Attribute {
	key = "ante"
}
-- Denotes an enemy OR interacts with enemies
SMODS.Attribute {
	key = "enemy"
}
-- Relates to Rot in some way
SMODS.Attribute {
	key = "rot"
}
-- Can kill you outright
SMODS.Attribute {
	key = "killer"
}

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
