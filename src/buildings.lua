buildings = {

    -- FIX: Theres gotta be a better way to do this
    layers = {},

    -- "Public" methods

    init = function(self)

        -- Create building layers
        add(self.layers, {
            buildings = {},
            speed = game:get_speed()/6,
            color = 10,
            h_max = 60,
            h_min = 30,
            w_max = 80,
            w_min = 10,
            gap = false
        })

        add(self.layers, {
            buildings = {},
            speed = game:get_speed()/4,
            color = 5,
            h_max = 50,
            h_min = 30,
            w_max = 60,
            w_min = 20,
            gap = true
        })

        -- Spawn initial buildings
        for _l in all(self.layers) do
            self:_init_layer(_l)
        end
    end,

    update = function(self)
        for _l in all(self.layers) do
            self:_update_layer(_l)
        end
    end,

    draw = function(self)
        for _l in all(self.layers) do
            for _m in all(_l.buildings) do
                self:_draw_building(_m)
            end
        end

    end,

    reset = function(self)
        self.layers = {}
    end,


    -- "Private" methods

    _init_layer = function(self, _l)
        local _nx = 10
        for i = 0, 5 do
            local _nw = self:_spawn_building(_nx, _l)
            _nx += _nw
            if _l.gap then
                _nx += rnd_between(8, 32)
            end
        end
    end,

    _update_layer = function(self, _l)
        -- Move all buildings
        for building in all(_l.buildings) do
            building.x -= _l.speed
        end

        -- Check if leftmost _lm building is off screen
        local _lm = _l.buildings[1]

        if _lm.x < -_lm.w then
            -- Remove _lm building
            del(_l.buildings, _lm)
        end

        -- Check if rightmost (_rm) building is on screen
        local _rm = _l.buildings[#_l.buildings]

        if _rm.x + _rm.w < 127 then
            -- Add new building to the right
            local _x = _rm.x + _rm.w

            if _l.gap then
                _x += rnd_between(8, 32)
            end
            self:_spawn_building(_x, _l)
        end

    end,

    _spawn_building = function(self, _x, _l)

        local _wh = rnd_between(3, 6)
        local _wg = rnd_between(2, 4)
        local _wn = rnd_between(2, 10)
        local _h = rnd_between(_l.h_min, _l.h_max)
        local _w = rnd_between(_l.w_min, _l.w_max)    

        -- 50/50 chance to have window squares
        local _windows = false
        if rnd() > 0.5 then
            _windows = true
            _w = (_wn * (_wh + _wg)) + _wg
        end
        
        
        add(_l.buildings, {
            x = _x,
            w = _w,
            h = _h,
            color = _l.color,
            gap = _l.gap,
            windows = _windows,
            wh = _wh,
            wg = _wg,
            wn = _wn,
        })

        return _w
    end,

    _draw_building = function(self, _b)
        _b = _b or {}
        local _h = _b.h or 42
        local _w = _b.w or 42
        local _x = _b.x or 0
        local _color = _b.color or 12

        rrectfill(_x, 96-_h, _w, _h, 1, _color)

        if _b.gap then

            -- Shadow line
            local _lx = _x + _w
            local _ly0 = 97 - _h
            local _ly1 = 96

            line(_lx, _ly0, _lx, _ly1, 3)

            -- Windows
            local _wg = _b.wg
            local _wh = _b.wh
            local _wn = _b.wn

            local _row = _wh + _wg
            local _count = flr(_h / _row)

            for i = 1, _count do
                local _wx = _x + _wg
                local _ww = _w - _wg * 2
                local _wy = 93 - _h + (i * (_wh+_wg))
                
                if _b.windows then
                    for j = 1, _wn do
                        rrectfill(_wx, _wy, _wh, _wh, 0, 15)
                        _wx += _wh + _wg
                    end
                else
                    rrectfill(_wx, _wy, _ww, _wh, 0, 15)
                end
                
            end

        end


    end,
}