game = {
    -- State management
    state = "playing",

    -- Game score
    score = 0,

    -- Difficulty settings
    base_difficulty = 1,
    spike_modifier = 0, -- Temporary difficulty spikes
    spike_timer = 0,

    -- "Public" methods
    reset = function(self)
        self.score = 0
        self.base_difficulty = 1
        self.spike_modifier = 0
        self.spike_timer = 0
        player:reset()
        gates:reset()
    end,

    switch_state = function(self, _ns)
        self.state = _ns
        log("switch_state(): " .. _ns)
    end,
    
    add_score = function(self, _ps)
        self.score += _ps
        self.base_difficulty = 1 + flr(self.score / DIFFICULTY_INCREASE_RATE)
        log("add_score(): score=" .. self.score .. " base_difficulty=" .. self.base_difficulty)
    end, 

    -- Effective difficulty
    get_effective_difficulty = function(self)
        return self.base_difficulty + self.spike_modifier
    end,

    -- Overall game speed (not effected by diffculty spikes)
    get_speed = function(self)
        return min(MAX_SPEED, SPEED_INCREASE_RATE * self.base_difficulty + (1 - SPEED_INCREASE_RATE))
    end,

    -- Manage lifecycle of difficulty spikes
    update_spike = function(self)
        -- Spike duration
        if self.spike_timer > 0 then
            self.spike_timer -= 1
            if self.spike_timer <= 0 then
                self.spike_modifier = 0
                log("update_spike(): spike ended")
            end
        end

        -- Spike spawner
        if self.score > 0 and self.score % SPIKE_INTERVAL == 0 and self.spike_modifier == 0 and self.score > SPIKE_INTERVAL-1 then
            self:_trigger_spike(SPIKE_DIFFICULTY, SPIKE_DURATION) 
            log("update_spike(): spike started")
        end
    end,

    -- "Private" methods
    _trigger_spike = function(self, _sm, _st)
        self.spike_modifier = _sm
        self.spike_timer = _st
        log("_trigger_spike(): spiked by " .. _sm .. " for " .. _st .. " frames")
    end

}