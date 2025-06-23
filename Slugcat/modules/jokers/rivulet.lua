SMODS.Joker({
	key = "rivulet",
	atlas = "slugcats",
	pos = { x = 6, y = 0 },
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	config = { extra = { randomnumber = 1 }, slugcat = true },

	calculate = function(self, card, context)
		local _suit, _rank = "S", "K"

		if context.skip_blind then
			card.ability.extra.randomnumber = math.random(1, 10)

			if card.ability.extra.randomnumber < 7 then
				_rank = pseudorandom_element(
					{ "A", "J", "Q", "K", "2", "3", "4", "5", "6", "7", "8", "9", "T" },
					pseudoseed("rivuletrank")
				)
				_suit = pseudorandom_element({ "S", "H", "D", "C" }, pseudoseed("rivuletsuit"))
				local card = create_playing_card(
					{
						front = G.P_CARDS[_suit .. "_" .. _rank],
						center = pseudorandom_element(G.P_CENTER_POOLS["Enhanced"], pseudoseed("rivuletscard")),
					},
					G.deck,
					nil,
					nil,
					{ G.C.SECONDARY_SET.Enhanced }
				)
			elseif card.ability.extra.randomnumber < 10 and card.ability.extra.randomnumber > 6 then
				_rank = pseudorandom_element(
					{ "A", "J", "Q", "K", "2", "3", "4", "5", "6", "7", "8", "9", "T" },
					pseudoseed("rivuletrank")
				)
				_suit = pseudorandom_element({ "S", "H", "D", "C" }, pseudoseed("rivuletsuit"))
				local card = create_playing_card(
					{
						front = G.P_CARDS[_suit .. "_" .. _rank],
						center = pseudorandom_element(G.P_CENTER_POOLS["Enhanced"], pseudoseed("rivuletscard")),
					},
					G.deck,
					nil,
					nil,
					{ G.C.SECONDARY_SET.Enhanced }
				)
				local card = create_playing_card(
					{
						front = G.P_CARDS[_suit .. "_" .. _rank],
						center = pseudorandom_element(G.P_CENTER_POOLS["Enhanced"], pseudoseed("rivuletscard")),
					},
					G.deck,
					nil,
					nil,
					{ G.C.SECONDARY_SET.Enhanced }
				)
			elseif card.ability.extra.randomnumber == 10 then
				_rank = pseudorandom_element(
					{ "A", "J", "Q", "K", "2", "3", "4", "5", "6", "7", "8", "9", "T" },
					pseudoseed("rivuletrank")
				)
				_suit = pseudorandom_element({ "S", "H", "D", "C" }, pseudoseed("rivuletsuit"))
				local card = create_playing_card(
					{
						front = G.P_CARDS[_suit .. "_" .. _rank],
						center = pseudorandom_element(G.P_CENTER_POOLS["Enhanced"], pseudoseed("rivuletscard")),
					},
					G.deck,
					nil,
					nil,
					{ G.C.SECONDARY_SET.Enhanced }
				)
				local card = create_playing_card(
					{
						front = G.P_CARDS[_suit .. "_" .. _rank],
						center = pseudorandom_element(G.P_CENTER_POOLS["Enhanced"], pseudoseed("rivuletscard")),
					},
					G.deck,
					nil,
					nil,
					{ G.C.SECONDARY_SET.Enhanced }
				)
				local card = create_playing_card(
					{
						front = G.P_CARDS[_suit .. "_" .. _rank],
						center = pseudorandom_element(G.P_CENTER_POOLS["Enhanced"], pseudoseed("rivuletscard")),
					},
					G.deck,
					nil,
					nil,
					{ G.C.SECONDARY_SET.Enhanced }
				)
			end
		end
	end,
})
