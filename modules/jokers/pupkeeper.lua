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
            pup_bee_mult = 2,
            growth = 3
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
        info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
        return {
            vars = { card.ability.extra.pup_bee_mult, card.ability.extra.pup_bee_mult * bee_debuffed_count(G and G.playing_cards or {}) }
        }
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability["rw_wbeehive"] = true
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and card.ability.extra.growth > 0 then
            card.ability.extra.growth = card.ability.extra.growth - 1
            if card.ability.extra.growth <= 0 then
                card.ability.extra.growth = nil
                card:grow_up()
            end
        end

        if context.joker_main then
            if bee_debuffed_count(G.playing_cards) > 0 then
                return { mult = card.ability.extra.pup_bee_mult * bee_debuffed_count(G.playing_cards) }
            end
        end
    end
}
