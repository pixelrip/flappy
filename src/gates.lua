-- gates.lua
-- "Gates" are the _safe passages the _pl must navigate through
-- Currently they are responsible for checking for collisions, but that
-- seems appropriate for scope of the game

gates = {

    list = {},
    spawn_timer = 0,
    next_gate = 0,

    -- "Public" methods 
    init = function(self)
        self:_spawn_gate(1,1)
    end,

    update = function(self, _pl)
        local _d = game:get_effective_difficulty()
        local _s = game:get_speed()

        self:_move_gates(_s, _pl)
        self:_gate_spawner(_d, _s)
    end,

    draw = function(self)
        for _gt in all(self.list) do
            rrectfill(_gt.x,0,_gt.w,_gt.y,0,3)
            rrectfill(_gt.x,_gt.y+_gt.h,_gt.w,128,0,3)
            
            -- DEBUG
            if DEBUG then
                print("y: ".._gt.y, _gt.x+1, _gt.y-18, 10)
                print("w: ".._gt.w, _gt.x+1, _gt.y-12, 10)
                print("h: ".._gt.h, _gt.x+1, _gt.y-6, 10)
                print("s: "..game:get_speed(), _gt.x+1, _gt.y+_gt.h+2, 10)
                print("b: "..game.base_difficulty, _gt.x+1, _gt.y+_gt.h+8, 10)
                print("d: "..game:get_effective_difficulty(), _gt.x+1, _gt.y+_gt.h+14, 10)

                print("mx: ".._gt.debug_max_gap, _gt.x+_gt.w+20, _gt.y-18, 10)
                print("mn: ".._gt.debug_min_gap, _gt.x+_gt.w+20, _gt.y-12, 10)
                print("g: ".._gt.debug_gap, _gt.x+_gt.w+20, _gt.y-6, 10)
            end

        end
    end,

    reset = function(self)
        self.list = {}
        self.spawn_timer = 0
    end,


    -- "Private" methods

    _move_gates = function(self, _s, _pl)

        for _gt in all(self.list) do
            _gt.x -= _s

            -- Check for collisions with _pl
            if self:_check_collided(_gt, _pl) then
                game:switch_state("game_over")
            end
            
            -- Delete _gt if it has moved off screen
            if _gt.x < -_gt.w then
                del(self.list, _gt)
            end
        end
    end,

    _gate_spawner = function(self, _d, _s)
        self.spawn_timer += 1

        if self.spawn_timer >= self.next_gate then
            self:_spawn_gate(_d, _s)
            self.spawn_timer = 0
        end
    end,

    _spawn_gate = function(self, _d, _s)
        local _w = self:_get_gate_width(_d)
        local _h = self:_get_gate_height(_d)
        local _y = self:_get_gate_y(_d, _h)

        -- Calculate the next spawn time based on difficulty
        -- Time for the gate to move on screen
        local _t = _w / _s
        -- Gap time based on difficulty
        local _offset = (_d - 1) * GATE_GAP_INCREMENT
        local _gmax = flr(max(GATE_GAP_MAX - _offset, GATE_CLAMP_GAP_MAX) / _s)
        local _gmin = flr(max(GATE_GAP_MIN - _offset, GATE_CLAMP_GAP_MIN) / _s)
        local _g = rnd_between(_gmin, _gmax)

        self.next_gate = _t + _g

        add(self.list, {
            x = 128, -- Start off screen
            y = _y,
            w = _w,
            h = _h,
            passed = false,

            -- DEBUG
            debug_max_gap = _gmax,
            debug_min_gap = _gmin,
            debug_gap = _g
        })

    end,
    
    _get_gate_y = function(self, _d, _h)
        return rnd_between(16, 112 - _h)
    end,

    _get_gate_height = function(self, _d)
        local _offset = (_d - 1) * GATE_HEIGHT_INCREMENT
        local _ghmax = max(GATE_BASE_MAX_HEIGHT - _offset, GATE_CLAMP_MAX_HEIGHT)
        local _ghmin = max(GATE_BASE_MIN_HEIGHT - _offset, GATE_CLAMP_MIN_HEIGHT)
        return rnd_between(_ghmin, _ghmax)
    end,

    _get_gate_width = function(self, _d)
        local _offset = (_d - 1) * GATE_WIDTH_INCREMENT
        local _gwmax = min(GATE_BASE_MAX_WIDTH + _offset, GATE_CLAMP_MAX_WIDTH)
        local _gwmin = min(GATE_BASE_MIN_WIDTH + _offset, GATE_CLAMP_MIN_WIDTH)
        return rnd_between(_gwmin, _gwmax)
    end,

    _check_collided = function(self, _gt, _pl)
        -- Check that _pl(ayer) is _safe
        -- _gt (gate)
        -- TODO: FIX: Using _pl sprite height/width magic number 13/17; make hitbox
        local _safe = false

        if not _gt.passed then
            if _pl.x + 17 < _gt.x then 
                _safe = true
            elseif _pl.x > _gt.x + _gt.w then 
                _safe = true
                _gt.passed = true
                game:add_score(1)
            elseif _pl.y > _gt.y and _pl.y + 13 < _gt.y + _gt.h then 
                _safe = true
            end
        else
            _safe = true
        end

        -- Log the collision for now
        if not _safe then
            log("_check_collided(): true")
            return true
        end
    end,
}

