SMODS.Stake({
	key = 'violence',
	loc_txt = {
		name = "Karma 1",
		text = { 'Two enemies roll per round.' },
	},
	prefix_config = { applied_stakes = { mod = false }, above_stake = { mod = false } },
	--unlocked_stake = "stake_lust",
	modifiers = function()
		G.GAME.modifiers.rw_extra_enemy_rolls = (G.GAME.modifiers.rw_extra_enemy_rolls or 0) + 1
	end,
	colour = HEX("000000"),
	applied_stakes = { 'white' },
	above_stake = 'white',
	atlas = "stakes",
	pos = { x = 0, y = 0 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
}) --implemented

SMODS.Stake({
	key = 'lust',
	loc_txt = {
		name = "Karma 2",
		text = { 'Played Heart Suits have a chance to be debuffed.', 'On decks with no heart suits, a random suit is instead picked.' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
		--tbd
	end,
	colour = HEX("000000"),
	applied_stakes = { 'violence' },
	above_stake = 'violence',
	atlas = "stakes",
	pos = { x = 1, y = 0 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'companion',
	loc_txt = {
		name = "Karma 3",
		text = { 'For Each Joker Obtained, 1/2 chance to get a second, common, eternal joker.' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
	
	end,
	colour = HEX("000000"),
	applied_stakes = { 'lust' },
	above_stake = 'lust',
	atlas = "stakes",
	pos = { x = 2, y = 0 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
}) -- implemented

SMODS.Stake({
	key = 'gluttony',
	loc_txt = {
		name = "Karma 4",
		text = { 'Food Cards and packs cost twice as much.' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
		--tbd
	end,
	colour = HEX("000000"),
	applied_stakes = { 'companion' },
	above_stake = 'companion',
	atlas = "stakes",
	pos = { x = 3, y = 0 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
}) -- implemented

local card_set_cost_ref = Card.set_cost
function Card:set_cost()
local ret = card_set_cost_ref(self)

if G.STATE == G.STATES.SHOP then
for _, v in ipairs(G.GAME.applied_stakes) do
if SMODS.stake_from_index(v) == "stake_rw_gluttony" then
if self.ability.set == "Booster" or self.ability.set == "foods" or self:has_attribute('foods') then
self.cost = self.cost * 2
end
return ret
end
end
end
end

SMODS.Stake({
	key = 'survival',
	loc_txt = {
		name = "Karma 5",
		text = { 'Ante Scales Faster' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
		--tbd
	end,
	colour = HEX("000000"),
	applied_stakes = { 'gluttony' },
	above_stake = 'gluttony',
	atlas = "stakes",
	pos = { x = 4, y = 0 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'k6',
	loc_txt = {
		name = "Karma 6",
		text = { 'Three enemy roll per round.' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
		G.GAME.modifiers.rw_extra_enemy_rolls = (G.GAME.modifiers.rw_extra_enemy_rolls or 0) + 2
	end,
	colour = HEX("000000"),
	applied_stakes = { 'survival' },
	above_stake = 'survival',
	atlas = "stakes",
	pos = { x = 0, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})


SMODS.Stake({
	key = 'k7',
	loc_txt = {
		name = "Karma 7",
		text = { 'Shop can no longer be rerolled.' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
		--tbd
	end,
	colour = HEX("000000"),
	applied_stakes = { 'k6' },
	above_stake = 'k6',
	atlas = "stakes",
	pos = { x = 1, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'k8',
	loc_txt = {
		name = "Karma 8",
		text = { 'Packs no longer appear in the shop.' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
		--tbd
	end,
	colour = HEX("000000"),
	applied_stakes = { 'k7' },
	above_stake = 'k7',
	atlas = "stakes",
	pos = { x = 2, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'k9',
	loc_txt = {
		name = "Karma 9",
		text = { 'Jokers have halved chance to spawn with weapons.' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
	end,
	colour = HEX("000000"),
	applied_stakes = { 'k8' },
	above_stake = 'k8',
	atlas = "stakes",
	pos = { x = 3, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})	--implemented


local apply_to_run_ref = Card.apply_to_run
function Card.apply_to_run()
local ret = apply_to_run_ref(self)

if G.STATE == G.STATES.SHOP then
for _, v in ipairs(G.GAME.applied_stakes) do
if SMODS.stake_from_index(v) == "stake_rw_k9" then
if center_table.ability.config.weapon == true then
center_table.rate = center_table.rate / 2
end
return ret
end
end
end
end

SMODS.Stake({
	key = 'k10',
	loc_txt = {
		name = "Karma 10",
		text = { 'Each Ante has a new challenge to beat. Failing a challenge makes you lose the run.' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
		--tbd
	end,
	colour = HEX("000000"),
	applied_stakes = { 'k9' },
	above_stake = 'k9',
	atlas = "stakes",
	pos = { x = 4, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})
