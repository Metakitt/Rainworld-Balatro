SMODS.Stake({
	key = 'stake_violence',
	loc_txt = {
		name = "Karma 1",
		text = { 'Two enemies roll per round.' },
	},
	prefix_config = { applied_stakes = { mod = false } },
	--unlocked_stake = "stake_lust",
	modifiers = function()
		--tbd
	end,
	colour = HEX("000000"),
	applied_stakes = { 'gold' },
	above_stake = 'gold',
	atlas = "stakes",
	pos = { x = 4, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'stake_lust',
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
	applied_stakes = { 'stake_violence' },
	above_stake = 'stake_violence',
	atlas = "stakes",
	pos = { x = 4, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'stake_companionship',
	loc_txt = {
		name = "Karma 3",
		text = { 'For Each Joker Obtained, 1/2 chance to get a second, common, eternal joker.' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
		--tbd
	end,
	colour = HEX("000000"),
	applied_stakes = { 'stake_lust' },
	above_stake = 'stake_lust',
	atlas = "stakes",
	pos = { x = 4, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'stake_gluttony',
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
	applied_stakes = { 'stake_companionship' },
	above_stake = 'stake_companionship',
	atlas = "stakes",
	pos = { x = 4, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'stake_survival',
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
	applied_stakes = { 'stake_gluttony' },
	above_stake = 'stake_gluttony',
	atlas = "stakes",
	pos = { x = 4, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'stake_k6',
	loc_txt = {
		name = "Karma 6",
		text = { 'Three enemy roll per round.' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
		--tbd
	end,
	colour = HEX("000000"),
	applied_stakes = { 'stake_survival' },
	above_stake = 'stake_survival',
	atlas = "stakes",
	pos = { x = 4, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'stake_k7',
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
	applied_stakes = { 'stake_k6' },
	above_stake = 'stake_k6',
	atlas = "stakes",
	pos = { x = 4, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'stake_k8',
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
	applied_stakes = { 'stake_k7' },
	above_stake = 'stake_k7',
	atlas = "stakes",
	pos = { x = 4, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'stake_k9',
	loc_txt = {
		name = "Karma 9",
		text = { 'Jokers have halved chance to spawn with weapons.' },
	},
	--prefix_config = {applied_stakes = { mod = false } },
	--unlocked_stake = "stake_violence",
	modifiers = function()
		--tbd
	end,
	colour = HEX("000000"),
	applied_stakes = { 'stake_k8' },
	above_stake = 'stake_k8',
	atlas = "stakes",
	pos = { x = 4, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})

SMODS.Stake({
	key = 'stake_k10',
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
	applied_stakes = { 'stake_k9' },
	above_stake = 'stake_k9',
	atlas = "stakes",
	pos = { x = 4, y = 1 },
	sticker_atlas = "stakes_sticker",
	sticker_pos = { x = 3, y = 1 }
})
