-- gates.lua
-- "Gates" are the _safe passages the _pl must navigate through
-- Currently they are responsible for checking for collisions, but that
-- seems appropriate for scope of the game

gates = {

    list = {},
    spawn_timer = 0,

    -- "Public" methods 
    init = function(self)
        self:_spawn_gate(1)
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
            print("y: ".._gt.y, _gt.x+1, _gt.y-18, 10)
            print("w: ".._gt.w, _gt.x+1, _gt.y-12, 10)
            print("h: ".._gt.h, _gt.x+1, _gt.y-6, 10)
            print("s: "..game:get_speed(), _gt.x+1, _gt.y+_gt.h+2, 10)
            print("b: "..game.base_difficulty, _gt.x+1, _gt.y+_gt.h+8, 10)
            print("d: "..game:get_effective_difficulty(), _gt.x+1, _gt.y+_gt.h+14, 10)

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
        if self.spawn_timer >= 128 then
            self:_spawn_gate(_d)
            self.spawn_timer = 0
        end
    end,

    _spawn_gate = function(self, _d)
        add(self.list, {
            x = 128,
            y = self:_get_gate_y(_d),
            w = self:_get_gate_width(_d),
            h = self:_get_gate_height(_d),
            passed = false
        })
    end,
    
    _get_gate_y = function(self, _d)
        local _lgy = 64 -- last gate y

        if #self.list > 0 then
            _lgy = self.list[#self.list].y
        end

        local _myd = 50 - (_d * 2) -- max y delta
        _myd = max(25, _myd)

        local _ny = rnd_between(_lgy - _myd, _lgy + _myd)
        return mid(20, _ny, 80)
    end,

    _get_gate_height = function(self, _d)
        local _gh = 50 - (_d * 1.5)
        return max(35, _gh)
    end,

    _get_gate_width = function(self, _d)
        local _gw = 20 - (_d * 2)
        return max(40, _gw)
    end,

    _check_collided = function(self, _gt, _pl)
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
            elseif _pl.y > _gt.y and _pl.y + _pl.sh < _gt.y + _gt.h then 
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

