-- gates.lua
-- "Gates" are the _safe passages the _pl must navigate through
-- Currently they check for collisions, but it seems appropriate for scope

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
    
    check_collided = function(self, _gt, _pl)
            -- Check that _pl(ayer) is _safe
            -- _gt (gate)
            -- FIX: Using _pl sprite height; make hitbox
            local _safe = false

            if not _gt.passed then
                if _pl.x + _pl.sw < _gt.x then 
                    _safe = true
                elseif _pl.x > _gt.x + _gt.w then 
                    _safe = true
                    _gt.passed = true
                    game:add_score(1)
                    log("_Gt passed!")
                elseif _pl.y > _gt.y and _pl.y + _pl.sh < _gt.y + _gt.h then 
                    _safe = true
                end
            else
                _safe = true
            end

            -- Log the collision for now
            if not _safe then
                log("Collision!")
                return true
            end
    end,

    update = function(self, _pl)
        -- Move gates
        for _gt in all(self.list) do
            _gt.x -= 1

            -- Check for collisions with _pl
            if self:check_collided(_gt, _pl) then
                game:switch_state("game_over")
            end
            
            -- Delete _gt if it has moved off screen
            if _gt.x < -_gt.w then
                del(self.list, _gt)
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
        for _gt in all(self.list) do
            rrectfill(_gt.x,0,_gt.w,_gt.y,0,3)
            rrectfill(_gt.x,_gt.y+_gt.h,_gt.w,128,0,3)
        end
    end
}

