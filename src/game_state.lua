game = {
    state = "playing",
    score = 0,

    reset = function(self)
        self.score = 0
        player:reset()
        gates:reset()
    end,

    switch_state = function(self, new_state)
        self.state = new_state
        log("Switched to state: " .. new_state)
    end

    
}