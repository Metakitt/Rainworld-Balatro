-- Maybe last used consumeable type changes the effect?
-- Lacuna's effect is normally as follows:
-- Items in consumeable slot give a buff (depending on type)
-- 10% chance for random item to be consumed and give its buff permanently.
-- I feel it'd be a bit hard to track; maybe Lacuna gains a buff depending on the type of item used?
-- Gives +1 consumeable slot when added to deck then removed when lacuna is gone.
-- We have the following types of items: Planets, Tarots, Foods, Weapons
-- Planets could give an extra level?
-- Or maybe its held items that give a buff; like:
-- It could be ONLY the leftmost held item.
-- Planets have a 25% chance to give you a level at the start of blind as long as you're holding onto the planet.
-- Tarot give different effects depending on the item.
-- Fool gives you a random tarot or random planet card at the start of blind.
-- Magician; Each scored hand has a 10% chance to become lucky.
-- High priestess gives you two random planet cards at the start of blind
-- Empress is like magician, but with mult cards.
-- The emperor is two random tarot cards at the start of blind.
-- Hierophant is like empress...
-- Lovers is like hierophant, but has a lower chance at 5%
-- Same with chariot
-- same with justice
-- Hermit gives 5$ extra at the end of blind.
-- Wheel of Fortune 1 in 10 chance to give edition to random joker at the end of blind
-- Strength; first hand played has their rank go up by one
-- Hanged Man destroys the first discard
-- Death destroys a random card, copies a different random card.
-- Temperance gives 50% of the value of current jokers as the end of blind.
-- The Devil has a 10% chance to make a scored hand gold.
-- Same for tower with stone
-- The star, the moon, the sun and the world have a 20% chance to make a scored hand that rank
-- Judgement; if there is room; make a random joker at the start of blind at a 50% chance.
-- Foods
-- Maybe to make it simpler;
-- Planets: 25% chance to give you a level at the start of blind.
-- Tarot: 1 of 3 effects:
-- Gives you a random tarot card; a random planet card or gives 5~10$ at the end of blind.
-- Spectral: 1 of 3 effects:
-- Adds a random seal to a random card in the deck at the start of blind; upgrades every poker hand (5% chance) at end of blind or destroys a random card and creates 3 random enhanced cards.
-- Food: 25% chance to give every card in hand +20 chips.
-- Weapon: Gives 2x Mult and 2x Chips
-- Even simpler:
-- Planets: 25% chance to level up a random hand at the start of blind.
-- Tarot: Gives a random tarot card if there is space at the start of blind.
-- Spectral: Adds a random seal to a random card in the deck at the start of blind.
-- Weapon: Gives 2x Mult and 2x Chips or maybe a like. 1 in 20 chance to give a weapon to a random joker?
-- Food: Give every card in hand +20 chips.
-- Description: "At the start of blind," "Leftmost consumable card"
-- "does an effect" "depending on its type." "Planet: 1 in 4 chance to level-up a random hand" "Tarot: Gives a random tarot card" "Spectral: Gives a random seal to a random card in the deck"
-- "Food: 1 in 4 chance to give every card in hand +20 chips"
-- "Weapon: 1 in 15 chance to give a random weapon to a random joker."

SMODS.Joker({
	key = "lacuna",
	atlas = "slugcats",
	pos = { x = 0, y = 3 },
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { hand_type = "none", odds = 4, oddswep = 15 }, slugcat = true },
	loc_vars = function(self, info_queue, card)
		return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		local consume = G.consumeables.cards[1]

		if context.setting_blind and consume ~= nil then
			if
				consume.ability.set == "Planet"
				and pseudorandom("randomlevel") < G.GAME.probabilities.normal / card.ability.extra.odds
			then
				--print ('levelupplanet')
				card.ability.extra.hand_type = pseudorandom_element(
					{
						"Flush",
						"Pair",
						"High Card",
						"Three of a Kind",
						"Full House",
						"Four of a Kind",
						"Flush",
						"Straight",
						"Two Pair",
						"Straight Flush",
					},
					pseudoseed("levelup")
				)
				update_hand_text(
					{ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 },
					{
						handname = localize(card.ability.extra.hand_type, "poker_hands"),
						chips = G.GAME.hands[card.ability.extra.hand_type].chips,
						mult = G.GAME.hands[card.ability.extra.hand_type].mult,
						level = G.GAME.hands[card.ability.extra.hand_type].level,
					}
				)
				level_up_hand(used_tarot, card.ability.extra.hand_type)
				update_hand_text(
					{ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 },
					{ mult = 0, chips = 0, handname = "", level = "" }
				)
			end

			if
				consume.ability.set == "Tarot"
				and context.main_eval
				and G.consumeables.config.card_limit > #G.consumeables.cards
			then
				--print ('tarot')
				local n_card = SMODS.create_card({ set = "Tarot", area = G.consumeables })
				G.consumeables:emplace(n_card)
			end

			if consume.ability.set == "Spectral" then
				--print ('spectral')

				--for k, v in pairs(G.deck.cards) do

				local chosen_card = pseudorandom_element(G.deck.cards, pseudoseed("test"))
				local seal_type = pseudorandom(pseudoseed("certsl"))
				if seal_type > 0.75 then
					chosen_card:set_seal("Red", true)
				elseif seal_type > 0.5 then
					chosen_card:set_seal("Blue", true)
				elseif seal_type > 0.25 then
					chosen_card:set_seal("Gold", true)
				else
					chosen_card:set_seal("Purple", true)
				end

				--end
			end

			if
				consume.ability.set == "foods"
				and pseudorandom("upgrade") < G.GAME.probabilities.normal / card.ability.extra.odds
			then
				local buffup = {}
				for i = 1, #G.hand.cards do
					buffup = G.hand.cards[i]
					buffup.ability.perma_bonus = buffup.ability.perma_bonus + 20
					buffup:juice_up(0.5, 0.5)
					SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, buffup)
				end
			end

			if
				consume.ability.set == "obtainweapon"
				and pseudorandom("upgrade") < G.GAME.probabilities.normal / card.ability.extra.oddswep
			then
				--print ('disaster')

				local jokers = {}
				for i, v in pairs(G.jokers.cards) do
					jokers[#jokers + 1] = v
				end

				local chosen_joker = jokers[math.random(1, #jokers)]
				local weapon = pseudorandom_element(
					{
						"rw_wbeehive",
						"rw_wcherrybomb",
						"rw_wspear",
						"rw_wspear_ele",
						"rw_wspear_exp",
						"rw_wspear_fire",
						"rw_wflashbang",
						"rw_wgrenade",
						"rw_wjokerifle",
						"rw_wrock",
						"rw_wsingularity",
						"rw_wsporepuff",
					},
					pseudoseed("levelup")
				)
				SMODS.Stickers[weapon]:apply(chosen_joker, true)
			end
		end
	end,
})
