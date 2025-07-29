local x_mult_jokers_keys = {
	"j_joker_stencil",
	"j_steel_joker",
	"j_black_board",
	"j_constellation",
	"j_cavendish",
	"j_card_sharp",
	"j_madness",
	"j_hologram",
	"j_vampire",
	"j_baron",
	"j_obelisk",
	"j_obelisk",
	"j_photograph",
	"j_lucky_cat",
	"j_baseball_card",
	"j_ramen",
	"j_ancient_joker",
	"j_campfire",
	"j_acrobat",
	"j_throwback",
	"j_bloodstone",
	"j_flower_pot",
	"j_hit_the_road",
	"j_seeing_double",
	"j_the_idol",
	"j_the_duo",
	"j_the_trio",
	"j_the_family",
	"j_the_order",
	"j_the_tribe",
	"j_drivers_license",
	"j_canio",
	"j_triboulet",
	"j_yorick",
	"j_rw_greedyscug",
	"j_rw_greedyscugbig",
	"j_rw_greedyscugsmall",
	"j_rw_gourmand",
	"j_rw_spearmaster",
	"j_rw_magician",
	"j_rw_hunger",
}

SMODS.Joker {
key = 'maturecentipede',
atlas = "enemies",
rarity = 'rw_enemy',
cost = 4,
pos = { x = 1, y = 3 },
unlocked = true,
discovered = true,
in_pool = function (self, args)
    return false
end,
config = { extra = {defeat = false, hand_count = 0}, enemy = true},
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
    return { vars = { card.ability.extra.hand_count } }
    end,
add_to_deck = function(self, card, from_debuff) 
SMODS.Stickers["eternal"]:apply(card,true)
    end,
calculate = function(self, card, context)

--Threat (Disables xMult jokers, and Jokers with xMult weapons. I decided not to count polychrome in this)
if context.main_eval and not context.blueprint then
			for _, center in ipairs(x_mult_jokers_keys) do
				if #SMODS.find_card(center, true) then
					for _, v in pairs(SMODS.find_card(center, true)) do
					SMODS.debuff_card(v, true, "maturecentipede")
					end
				end
			end
			for _,v in ipairs(G.jokers.cards) do
 if (v.ability.rw_wspear_exp == true 
 or v.ability.rw_wspear == true 
 or v.ability.rw_wspear_ele == true  
 or v.ability.rw_wspear_fire == true)
 and not context.blueprint then
 SMODS.debuff_card(v, true, "maturecentipede")
 end
		end

--Defeat (Score 3 hands)
 if context.after and card.ability.extra.defeat == false and not context.blueprint then
    card.ability.extra.hand_count = card.ability.extra.hand_count + 1
end

if card.ability.extra.hand_count >= 3 then
card.ability.extra.defeat = true
end

 if context.after and card.ability.extra.defeat == true and not context.blueprint then
 for _,v in ipairs(G.jokers.cards) do
 SMODS.debuff_card(v, "reset", "maturecentipede")
 end
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
--Undefeated (Destroys all debuffed jokers)

if context.main_eval and context.end_of_round and G.GAME.blind.boss and card.ability.extra.defeat == false and not context.blueprint  then
for _,v in ipairs(G.jokers.cards) do
if v.debuff then
SMODS.destroy_cards(v, true)
end
end


end
end
end
	}
