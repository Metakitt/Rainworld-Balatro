--[[Threat: At the start of each blind, 1 in 12 chance for each card in your deck/hand/joker to become rot.
Defeat condition: Score 1 hands with a singularity bomb.
If not defeated: Chooses a random suit. Turns it to rot.]]

SMODS.Joker {
key = 'motherlonglegs',
atlas = 'enemies',
rarity = 'rw_enemy',
cost = 4,
pos = { x = 0, y = 4 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, odds = 12, bombattack = 0}, enemy = true},
blueprint_compat = false,
perishable_compat = false,
rw_wbeehive_compat = false,
rw_wcherrybomb_compat = false,
rw_wspear_ele_compat = false,
rw_wspear_exp_compat = false,
rw_wspear_fire_compat = false,
rw_wflashbang_compat = false,
rw_wgrenade_compat = false,
rw_wjokerifle_compat = false,
rw_wrock_compat = false,
rw_wsingularity_compat = false,
rw_wspear_compat = false,
rw_wsporepuff_compat = false,
loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {key = "rw_wspear_exp", set = "Other"}
    return { vars = { card.ability.extra.odds, card.ability.extra.bombattack } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat
if context.setting_blind and not context.blueprint then
for i = 1, #G.deck.cards do
if pseudorandom('bite') < 1 / card.ability.extra.odds and not context.blueprint then
G.deck.cards[i]:set_ability(G.P_CENTERS.m_rw_rotting)
end
end
for i = 1, #G.hand.cards do
if pseudorandom('bite') < 1 / card.ability.extra.odds and not context.blueprint then
G.hand.cards[i]:set_ability(G.P_CENTERS.m_rw_rotting)
end
end
for i = 1, #G.jokers.cards do
if pseudorandom('bite') < 1 / card.ability.extra.odds and not context.blueprint then
G.jokers.cards[i]:set_rotted()
end
end

end
	--Defeat
	if context.joker_main and not context.blueprint then

		card.ability.extra.bombattack = card.ability.extra.bombattack + SCUG.weapon_count("rw_wsingularity")
		if card.ability.extra.bombattack >= 1 then
			card.ability.extra.defeat = true
		end
	end
 if context.after and card.ability.extra.defeat == true and not context.blueprint then
 G.E_MANAGER:add_event(Event({
    trigger = "after", 
    delay = 1.3, 
    func = function() 
        SMODS.destroy_cards(card, true) 
        return true 
    end,
	 blocking = false
}))
 
end
--Undefeated
	if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint then
    local rank = SCUG.get_rank_in_deck() --pseudorandom_element(SMODS.Ranks, pseudoseed("rotten_rank"))
	local destroyablejokers = EMPTY(destroyablejokers)
    for _, v in ipairs(G.deck.cards) do
        if v.config.card.value == rank and not context.blueprint then
            v:set_ability(G.P_CENTERS.m_rw_rotting)
        end
    end
	for k, v in pairs(G.jokers.cards) do
				if v.ability.set == "Joker" and not v.ability.eternal then
					table.insert(destroyablejokers, v)
				end
			end

			local chosen_card = pseudorandom_element(destroyablejokers, pseudoseed("test"))
			if
				chosen_card ~= nil
				and not chosen_card.getting_sliced
				and not context.blueprint
			then
				SMODS.destroy_cards(chosen_card)
			end
end
	end
	}