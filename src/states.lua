current_state = nil

states = {}

states.title = {
    anim_timer = 0,
    anim_y = 128,
    anim_state = "playing", -- "playing, complete, ready"

    init = function(self)
        -- Initialize title state
        music(0)
    end,

    update = function(self)
        if self.anim_state == "playing" then
            if self.anim_y > 16 then
                self.anim_timer += 1

                if self.anim_timer % 30 == 0 then
                    self.anim_y -= 8
                end
            else
                self.anim_state = "complete"
            end

            for i = 0, 5 do
                if input:onpress(i) then
                    self.anim_state = "complete"
                end
            end
            return
        end

        if self.anim_state == "complete" then
            self.anim_y = 16

            for i = 0, 5 do
                if input:onpress(i) then
                    self.anim_state = "ready"
                end
            end
            return
        end

        if self.anim_state == "ready" then
            if input:onpress(4) then
                switch_state(states.playing)
            end
            return
        end
    end,

    draw = function(self)
        cls(0)
        font:print("BIRD", 12, self.anim_y)
        font:print("FLAP", 12, self.anim_y + 28)
        font:print("programme", 12, self.anim_y + 56)

        if self.anim_state == "complete" then
            print_centered("approved by the ministry", 93, 7)
            print_centered("of bird migration control", 100, 7)
        elseif self.anim_state == "ready" then
            print_centered("high score: "..game.high_score, 93, 7)
            print_centered("press 🅾️ to begin", 102, 7)
        end
    end
}

states.playing = {
    init = function(self)
        music(-1,10000)
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
    new_high_score = false,

    init = function(self)
        sfx(1) -- hit sound
        sfx(3) -- game_over

        if game.score > game.high_score then
            game.high_score = game.score
            self.new_high_score = true
            save:save_all()
        end
    end,

    update = function(self)
        if input:onpress(4) then 
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

        font:print("game over", 14, 56)
        print_centered("glory to arstotzka", 40, 7, "\^oaff")

        if self.new_high_score then
            print_centered("new high score: "..game.score, 70, 7, "\^obe0")
        else
            print_centered("your score: "..game.score, 70, 7, "\^obe0")
        end
    end
}

function switch_state(new_state)
    current_state = new_state
    if current_state.init then
        current_state:init()
    end
end
