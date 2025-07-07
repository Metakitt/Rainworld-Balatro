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
assert(SMODS.load_file("./modules/enemies.lua"))()
--assert(SMODS.load_file("./modules/debug.lua"))()

--Debug allows for the use of the Rot fruit for testing rot! Wet fruit as well for wet cards!

SMODS.Sound({
	key = "crunch",
	path = {
		["default"] = "crunch.mp3",
	},
})

SMODS.Enhancement({
	key = "rotting",
	config = { bonus = -25, countdown_to_destruction = 5 },
	atlas = "enhancedcards_scug",
	pos = { x = 0, y = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.countdown_to_destruction } }
	end,
	weight = 5,
	in_pool = function(self, args)
		if args and args.source == "sta" then
			return true
		else
			return false
		end
	end,
})

SMODS.Enhancement({
	key = "wetasscard",
	loc_txt = {
		name = "Wet",
		text = {
			"Wet",
			"#1#",
		},
	},
	config = { x_chips = 1.5, countdown_to_dry = 5 },
	atlas = "enhancedcards_scug",
	pos = { x = 2, y = 0 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.countdown_to_dry } }
	end,
	weight = 5,
	always_scores = true,
})

-- Patches for Game Functions

local wetcardedit = end_round
function end_round()
	wetcardedit()
	for k, x in pairs(G.deck.cards) do
		if x.config.center == G.P_CENTERS.m_rw_wetasscard and not x.debuff then
			local enhanced = {}
			enhanced[#enhanced + 1] = x
			x.ability.countdown_to_dry = x.ability.countdown_to_dry - 1

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
				end
			end
		end
	end

	--For cards in the hand at the end of the round;
	for k, x in pairs(G.hand.cards) do
		if x.config.center == G.P_CENTERS.m_rw_wetasscard and not x.debuff then
			local enhanced = {}
			enhanced[#enhanced + 1] = x
			x.ability.countdown_to_dry = x.ability.countdown_to_dry - 1

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
				end
			end
		end
	end
end

local rotting_blind = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play()
	rotting_blind()

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
	for k, x in pairs(G.deck.cards) do
		if x.config.center == G.P_CENTERS.m_rw_rotting and not x.debuff then
			local enhanced = {}
			enhanced[#enhanced + 1] = x
			x.ability.countdown_to_destruction = x.ability.countdown_to_destruction - 1

			if x.ability.countdown_to_destruction == 0 then
				--Destruction part of function
				local z = {}
				for i = 1, #G.deck.cards do
					if
						G.deck.cards[i].config.center == G.P_CENTERS.m_rw_rotting
						and G.deck.cards[i].ability.countdown_to_destruction < 1
					then
						z = G.deck.cards[i]
						z:start_dissolve()

						--SMODS.calculate_effect({message = localize('k_upgrade_ex')}, artirot)
					end
				end
				--Artificer's check
				if next(SMODS.find_card("j_rw_artificer")) then
					for i = 1, #SMODS.find_card("j_rw_artificer") do
						local artirot = SMODS.find_card("j_rw_artificer")[i]
						artirot.ability.extra.chips = artirot.ability.extra.chips + artirot.ability.extra.bonus_chips
					end
				end
			end

			-- 1 in 5 chance to make another random card a rot card.
			local timeforrot = pseudorandom("rw_rot") < 0.2 -- Also 1 in 5
			if timeforrot then
				local notrot = {}
				for i = 1, #G.deck.cards do
					if
						G.deck.cards[i] ~= card
						and G.deck.cards[i].config.center ~= G.P_CENTERS.m_rw_rotting
						and not G.deck.cards[i].getting_sliced
					then
						notrot[#notrot + 1] = G.deck.cards[i]
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

--Definitions for Localization
G.C.FOOD = HEX("0736f3")
G.C.WEAPON = HEX("875796")

function loc_colour(_c, _default)
	G.ARGS.LOC_COLOURS = G.ARGS.LOC_COLOURS
		or {
			food = G.C.FOOD,
			weapon = G.C.WEAPON,
			red = G.C.RED,
			mult = G.C.MULT,
			blue = G.C.BLUE,
			chips = G.C.CHIPS,
			green = G.C.GREEN,
			money = G.C.MONEY,
			gold = G.C.GOLD,
			attention = G.C.FILTER,
			purple = G.C.PURPLE,
			white = G.C.WHITE,
			inactive = G.C.UI.TEXT_INACTIVE,
			spades = G.C.SUITS.Spades,
			hearts = G.C.SUITS.Hearts,
			clubs = G.C.SUITS.Clubs,
			diamonds = G.C.SUITS.Diamonds,
			tarot = G.C.SECONDARY_SET.Tarot,
			planet = G.C.SECONDARY_SET.Planet,
			spectral = G.C.SECONDARY_SET.Spectral,
			edition = G.C.EDITION,
			dark_edition = G.C.DARK_EDITION,
			legendary = G.C.RARITY[4],
			enhanced = G.C.SECONDARY_SET.Enhanced,
		}
	return G.ARGS.LOC_COLOURS[_c] or _default or G.C.UI.TEXT_DARK
end
