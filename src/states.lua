current_state = nil

states = {}

states.title = {
    init = function(self)
        -- Initialize title state
    end,

    update = function(self)
        if btnp(4)then -- Z or X key
            switch_state(states.playing)
        end
    end,

    draw = function(self)
        cls(0)
        font:print("BIRD", 0, 0)
        font:print("FLAP", 0, 28)
        font:print("programme", 0, 56)
    end
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
    end
}

states.game_over = {
    init = function(self)
        -- Calculate final score or other game over logic
    end,

    update = function(self)
        if btnp(4) then 
            switch_state(states.playing)
        end
    end,

    draw = function(self)
        cls(15)
        clouds:draw()
        buildings:draw()
        floor:draw()
        gates:draw()
        player:draw()
        print("GAME OVER", 40, 40, 8)
        print("Score: "..game.score, 45, 60, 7)
        print("Press o to restart", 20, 80, 7)
    end
}

function switch_state(new_state)
    current_state = new_state
    if current_state.init then
        current_state:init()
    end
end
