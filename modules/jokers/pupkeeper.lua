---@param card_table table
---@return number
local function bee_debuffed_count(card_table)
    local count = 0
    for _, v in ipairs(card_table) do
        if v.ability.debuff_sources and v.ability.debuff_sources["bees"] then
            count = count + 1
        end
    end
    return count
end

SMODS.Joker {
    key = "pupkeeper",
    config = {
        extra = {
            bee_mult = 0.05
        }
    },
    rarity = 1,
    cost = 5,
    atlas = "slugcats",
    pos = { x = 5, y = 6 },
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.bee_mult, 1 + (card.ability.extra.bee_mult * bee_debuffed_count(G and G.playing_cards or {})) }
        }
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability["rw_wbeehive"] = true
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if bee_debuffed_count(G.playing_cards) > 0 then
                return { xmult = 1 + (card.ability.extra.bee_mult * bee_debuffed_count(G.playing_cards)) }
            end
        end
    end
}
