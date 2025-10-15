current_state = nil

states = {}

states.title = {
    init = function(self)
        -- Initialize title state
    end,

    update = function(self)
        if btnp(5)then -- Z or X key
            switch_state(states.playing)
        end
    end,

    draw = function(self)
        cls(0)
        print("FLAPPY", 50, 40, 7)
        print("Press x to start", 20, 60, 7)
    end,

    reset = function(self)
        -- Reset title state if needed
    end,
}

states.playing = {
    init = function(self)
        game:reset()
        gates:init()
	    clouds:init()
	    buildings:init()
    end,

    update = function(self)
        game:update_spike()
		clouds:update()
		buildings:update()
		player:update()
		floor:update()
		gates:update(player)
    end,

    draw = function(self)
        cls(15)
        clouds:draw()
        buildings:draw()
        floor:draw()
        gates:draw()
        player:draw()
        print(game.score, 2, 122, 7)
    end,

    reset = function(self)
        game:reset()
        gates:reset()
        player:reset()
    end,
}

states.game_over = {
    init = function(self)
        -- Calculate final score or other game over logic
    end,

    update = function(self)
        if btnp(5) then 
            switch_state(states.playing)
        end
    end,

    draw = function(self)
        cls(0)
        print("GAME OVER", 40, 40, 8)
        print("Score: "..game.score, 45, 60, 7)
        print("Press x to restart", 20, 80, 7)
    end,

    reset = function(self)
        -- Reset game over state if needed
    end,
}

function switch_state(new_state)
    current_state = new_state
    if current_state.init then
        current_state:init()
    end
end
