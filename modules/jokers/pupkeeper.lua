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
    attributes = { "slugcat", "mult", "full_deck" },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "slugpup_grows_up", vars = { card.ability.extra.growth } }
        return {
            vars = { card.ability.extra.pup_bee_mult, card.ability.extra.pup_bee_mult * SCUG.bee_debuffed_count(G and G.playing_cards or {}) }
        }
    end,
    set_ability = function(self, card, initial, delay_sprites)
        SMODS.Stickers["rw_wbeehive"]:apply(card, true)
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
            return { mult = card.ability.extra.pup_bee_mult * SCUG.bee_debuffed_count(G.playing_cards) }
        end
    end
}
