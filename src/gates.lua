-- gates.lua
-- "Gates" are the _safe passages the _pl must navigate through
-- Currently they are responsible for checking for collisions, but that
-- seems appropriate for scope of the game

gates = {

    DEBUG = true, 
    list = {},
    spawn_timer = 0,
    next_gate = 0,
    count = 0,

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
            self:_draw_gate(_gt)
            
            -- DEBUG
            if self.DEBUG then
                --[[
                print("y: ".._gt.y, _gt.x+1, _gt.y-18, 7)
                print("w: ".._gt.w, _gt.x+1, _gt.y-12, 7)
                print("h: ".._gt.h, _gt.x+1, _gt.y-6, 7)
                print("s: "..game:get_speed(), _gt.x+1, _gt.y+_gt.h+2, 7)
                print("b: "..game.base_difficulty, _gt.x+1, _gt.y+_gt.h+8, 7)
                print("d: "..game:get_effective_difficulty(), _gt.x+1, _gt.y+_gt.h+14, 7)

                print("mx: ".._gt.debug_max_gap, _gt.x+_gt.w+20, _gt.y-18, 7)
                print("mn: ".._gt.debug_min_gap, _gt.x+_gt.w+20, _gt.y-12, 7)
                print("g: ".._gt.debug_gap, _gt.x+_gt.w+20, _gt.y-6, 7)
                ]]--
            end

        end
    end,

    reset = function(self)
        self.list = {}
        self.spawn_timer = 0
        self.next_gate = 0
    end,


    -- "Private" methods

    _move_gates = function(self, _s, _pl)

        for _gt in all(self.list) do
            _gt.x -= _s

            -- Check for collisions with _pl
            if self:_check_collided(_gt, _pl) then
                switch_state(states.game_over)
            end
            
            -- Delete _gt if it has moved off screen
            if _gt.x < -_gt.w - 7 then
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
        if self.DEBUG then
            self.count += 1
            log("\nspawn_gate(): "..self.count)
            log("   difficulty: ".._d)
            log("   speed: ".._s)
        end

        local _w = self:_get_gate_width(_d)
        local _h = self:_get_gate_height(_d)
        local _y = self:_get_gate_y(_d, _h)

        self.next_gate = self:_get_next_gate(_d, _s, {
            w = _w,
            h = _h,
            y = _y
        })


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

    _get_next_gate = function(self, _d, _s, _cur)
        -- Calculate the next spawn TIME (in frames) based on difficulty
        -- Number of frames until the current gate is on the screen
        local _t = flr(_cur.w / _s)

        -- Gap time based on difficulty
        local _offset = (_d - 1) * GATE_GAP_INCREMENT -- 0, 4, 8, 12, 16...68
        local _gmin = flr(max(GATE_GAP_MIN - _offset, GATE_CLAMP_GAP_MIN))
                              -- max(64 - 0, 32) / 1 = 64
                              -- max(64 - 68, 32) / 4 = 8
        local _gmax = flr(max(GATE_GAP_MAX - _offset, GATE_CLAMP_GAP_MAX))
                              -- max(128 - 0, 64) / 1 = 128
                              -- max(128-68, 64) / 4 = 16
        local _g = rnd_between(_gmin, _gmax)
        
        if self.DEBUG then
            log("   _get_next_gate(): ")
            log("      _t = ".._t)
            log("      _g = rnd_between(".._gmin..", ".._gmax..") -> ".._g)
            log("      next_gate = ".._t+_g)
        end
        
        return _t + _g

    end,
    
    _get_gate_height = function(self, _d)
        local _offset = (_d - 1) * GATE_HEIGHT_INCREMENT
        local _ghmax = max(GATE_BASE_MAX_HEIGHT - _offset, GATE_CLAMP_MAX_HEIGHT)
        local _ghmin = max(GATE_BASE_MIN_HEIGHT - _offset, GATE_CLAMP_MIN_HEIGHT)
        
        --DEBUG: Could directly return rnd_between
        local _r = rnd_between(_ghmin, _ghmax)
        if self.DEBUG then
            log("   _get_gate_height(): rnd_between(".._ghmin..", ".._ghmax..") = ".. _r)
        end
        
        return _r
    end,
    
    _get_gate_y = function(self, _d, _h)
        -- DEBUG: Could directly return rnd_between
        local _r = rnd_between(28, 101 - _h)
        if self.DEBUG then
            log("   _get_gate_y(): rnd_between(28,"..101-_h..") = ".._r)
        end
        return _r
    end,

    _get_gate_width = function(self, _d)
        local _offset = (_d - 1) * GATE_WIDTH_INCREMENT
        local _gwmax = min(GATE_BASE_MAX_WIDTH + _offset, GATE_CLAMP_MAX_WIDTH)
        local _gwmin = min(GATE_BASE_MIN_WIDTH + _offset, GATE_CLAMP_MIN_WIDTH)
        
        -- DEBUG: Could directly return rnd_between
        local _r = rnd_between(_gwmin, _gwmax)
        if self.DEBUG then
            log("   _get_gate_width: rnd_between(".._gwmin..", ".._gwmax..") = ".._r)
        end
        return _r
    end,

    _check_collided = function(self, _gt, _pl)
        -- Check that _pl(ayer) is _safe
        -- _gt (gate)
        if _gt.passed then return false end

        local _hb = _pl:get_bounds()
        local _safe = false

        if _hb.x2 < _gt.x then
            -- Left of gate
            _safe = true
        elseif _hb.x1 > _gt.x + _gt.w then
            -- Right of gate
            _safe = true
            _gt.passed = true
            game:add_score(1)
        elseif _hb.y1 > _gt.y and _hb.y2 < _gt.y + _gt.h then
            _safe = true
        end

        -- Log the collision for now
        if not _safe then
            if self.DEBUG then
                log("COLLISION")
            end
            return true
        end
    end,

    _draw_gate = function(self, _gt)
        _x = _gt.x
        _y = _gt.y
        _w = _gt.w
        _h = _gt.h

        local _bx0 = _x
        local _by0 = 0
        local _bx1 = _x + _w
        local _by1 = _y

        local _gx0 = _x
        local _gy0 = _y + _h
        local _gx1 = _x + _w
        local _gy1 = 119

        local _banner_sprite = {sx=51, sy=32, sw=21, sh=16}
        local _gate_sprite = {sx=51, sy=22, sw=19, sh=10, sa=12}

        -- Banner
        rectfill(_bx0,_by0,_bx1,_by1,8) -- red base
        rect(_bx0,-1,_bx1,_by1,0) -- black outline
        rect(_bx1,0,_bx1+1,_by1,0) -- shadow
        rect(_bx0+1,-1,_bx1-1,_by1-1,14) --pink outline
        draw_sprite(_bx0+(_w-21)/2, _by1-17, _banner_sprite)
        

        -- Gate
        rectfill(_gx0,_gy0,_gx1,_gy1,6) -- base grey

        -- Bricks
        local _bxh = max(0, _gy1 - _gy0 - 19)
        local _rows = flr(_bxh / 10)
        local _rem = _bxh % 10 + 1
        local _bxy = _gy0 + 19

        if _rows > 0 then
            for i = 1, _rows do
                draw_sprite(
                    _gx0,
                    _bxy,
                    {
                        sx=69, 
                        sy=22, 
                        sw=_w, 
                        sh=10, 
                        sa=12
                    })
                _bxy += 10
            end
        end
        if _rem > 0 then
            draw_sprite(
                _gx0,
                _bxy,
                {
                    sx=69, 
                    sy=22, 
                    sw=_w, 
                    sh=_rem, 
                    sa=12
                })
        end



        rect(_gx0+1,_gy0+1,_gx1,_gy0+19,7) -- white accent
        rect(_gx0,_gy0,_gx1,_gy1+1,0) -- black outline
        line(_gx0,_gy0+19,_gx1,_gy0+19,0) 
        line(_gx1+1,_gy0,_gx1+1,_gy1,0)
        rrectfill(_gx0+4,_gy0+4,_w-7,12,1,0) -- window
        draw_sprite(_gx0+(_w-19)/2, _gy0+6, _gate_sprite)

        -- Gate Shadow
        if _gy0 < 96 then
            rrectfill(_gx1+2, 96, 7, 24, 0, 3) 
        else
            rectfill(_gx1+2, _gy0+1, _gx1+8, _gy1, 3)
        end

    end
}

