-- "Gates" are the safe passages the player must navigate through
-- In OG Flappy Bird, its the space between the pipes

gates = {

    list = {},
    spawn_timer = 0,
    spawn_interval = 90, -- frames

    init = function(self)
        --start with one gate
        self:spawn_gate()
    end,

    spawn_gate = function(self)
        add(self.list, {
            x = 128,
            y = rnd_between(20, 80),
            w = rnd_between(20, 40),
            h = rnd_between(30, 50),
            passed = false
        })
    end,

    reset = function(self)
        self.list = {}
        self.spawn_timer = 0
    end,

    update = function(self)
        -- Move gates
        for gate in all(self.list) do
            gate.x -= 1

            -- Check that player is safe
            -- FIX: Using player sprite height; make hitbox
            local safe = false
            if not gate.passed then
                if player.x + player.sw < gate.x then 
                    safe = true
                elseif player.x > gate.x + gate.w then 
                    safe = true
                    gate.passed = true
                    log("Gate passed!")
                elseif player.y > gate.y and player.y + player.sh < gate.y + gate.h then 
                    safe = true
                end
            else
                safe = true
            end

            -- Log the collision for now
            if not safe then
                log("Collision!")
                game:switch_state("game_over")
            end


            -- Delete gate if it has moved off screen
            if gate.x < -gate.w then
                del(self.list, gate)
            end
        end

        -- Spawn new gates
        self.spawn_timer += 1
        if self.spawn_timer >= self.spawn_interval then
            self:spawn_gate()
            self.spawn_timer = 0
        end
    end,

    draw = function(self)
        -- RRECTFILL(X, Y, W, H, R, [COL])
        for gate in all(self.list) do
            rrectfill(gate.x,0,gate.w,gate.y,0,3)
            rrectfill(gate.x,gate.y+gate.h,gate.w,128,0,3)
        end
    end
}

