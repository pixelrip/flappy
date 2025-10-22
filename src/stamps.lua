-- stamps
stamps = {

    -- DEBUG
    DEBUG = true,

    -- sprites
    approved = make_sprite("72,32,17,11,0"),
    denied = make_sprite("89,32,17,11,0"),

    list = {},

    -- "Public" methods
    reset = function(self)
        self.list = {}
    end,

    update = function(self)
        for _st in all(self.list) do
            if _st.t > 0 then
                _st.t -= 1
            end
            
            if _st.x < -20 then
                del(self.list, _st)
            end
        end
    end,

    draw = function(self)
        for _st in all(self.list) do
            self:_animate_stamp(_st)
        end
    end,

    create = function(self, _p, _t)
        self:_spawn_stamp(_p, _t)
    end,

    -- "Private"
    _spawn_stamp = function(self, _p, _t)
        local _sprite = {}

        if _t == "approved" then
            _sprite = self.approved
        elseif _t == "denied" then
            _sprite = self.denied
        end

        add(self.list, {
            x = _p.x,
            y = _p.y - 16,
            sx = _sprite.sx,
            sy = _sprite.sy,
            sw = _sprite.sw,
            sh = _sprite.sh,
            sa = _sprite.sa,
            t = 12,
        })

    end,

    _animate_stamp = function(self, _st)
        -- 12 frames
        -- 12-11, stamp "up"
        -- 10-9, stamp "down" (pressed)
        -- 8-1, stamp "complete"
        -- 0, floating off screen

        local _s = game:get_speed()

        if _st.t == 9 then
            _st.y += 2
        end

        if _st.t == 6 then
            _st.y -= 2
        end

        if _st.t <= 0 then
            _st.x -= _s
        end

        if _st.t > 9 then
            pal(12, 10)
            pal(13, 3)
            draw_sprite(_st.x, _st.y, _st)
        elseif _st.t <= 9 and _st.t >= 6 then
            palt(13, true)
            draw_sprite(_st.x, _st.y, _st)
        else
            draw_sprite(_st.x, _st.y, _st)
        end

    end,

}
