SMODS.Joker {
    key = "keeper",
    config = {
        extra = {
            bee_mult = 0.05
        }
    },
    rarity = 1,
    cost = 5,
    atlas = "slugcats",
    pos = { x = 7, y = 3 },
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    attributes = { "slugcat", "xmult", "full_deck" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.bee_mult, 1 + (card.ability.extra.bee_mult * SCUG.bee_debuffed_count(G and G.playing_cards or {})) }
        }
    end,
    set_ability = function(self, card, initial, delay_sprites)
        SMODS.Stickers["rw_wbeehive"]:apply(card, true)
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { xmult = 1 + (card.ability.extra.bee_mult * SCUG.bee_debuffed_count(G.playing_cards)) }
        end
    end
}
