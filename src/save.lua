save = {
    slots = {
        high_score = 0
        -- sound_enabled = 1
        -- total_games = 2
        -- etc
    },

    init = function(self)
        cartdata("bird_flap_v1")
    end,

    load_all = function(self)
        game.high_score = dget(self.slots.high_score)
    end,

    save_all = function(self)
        dset(self.slots.high_score, game.high_score)
    end
}