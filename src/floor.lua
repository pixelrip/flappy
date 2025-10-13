floor = {
    x_offset = {
        ground = 0,
        wire = 0,
        texture = 0,
    },

    --sprite
    sprite = {
        ground = {
            sx = 0,
            sy = 35,
            sw = 48,
            sh = 8,
            sa = 15
        },
        wire = {
            sx = 0,
            sy = 30,
            sw = 26,
            sh = 5,
            sa = 12
        },
        texture = {
            sx = 19,
            sy = 15,
            sw = 10, 
            sh = 6,
            sa = 12,
        }
    },

    cracks = {
        data = {
            "38,0,13,15",
            "29,15,7,9",
            "36,15,6,9",
            "42,15,9,20",
            "19,21,10,9",
            "29,24,13,11"
        },
        current = 1,
        spawn_timer = 0,
        next_crack = 0,
        list = {}
    },

    update = function(self)
        local _s = game:get_speed()

        -- update offsets
        for k,v in pairs(self.x_offset) do
            self.x_offset[k] -= _s
            if self.x_offset[k] <= -self.sprite[k].sw then
                self.x_offset[k] = 0
            end
        end

        -- move cracks
        self:_move_cracks(_s)
        self:_crack_spawner(_s)
    end,

    draw = function(self)
        -- ground
        self:_draw_scroller(120, self.sprite.ground, self.x_offset.ground)
        
        -- barbed wire
        self:_draw_scroller(90, self.sprite.wire, self.x_offset.wire)
        
        -- fence
        line(0, 95, 127, 95, 0)
        rectfill(0,96,127,119,15)
        self:_draw_scroller(114, self.sprite.texture, self.x_offset.texture)

        -- cracks
        for _cr in all(self.cracks.list) do
            self:_draw_crack(_cr)
        end
    end,

    -- "Private" methods
    _draw_scroller = function(self, _y, _s, _o)
        local _w = _s.sw
        local _a = (flr(128/ _w) + 1) * _w
        
        for i = 0, _a, _w do
            draw_sprite(i + _o, _y, _s)
        end        
    end,

    _move_cracks = function(self, _s)
        for _cr in all(self.cracks.list) do
            _cr.x -= _s

            if _cr.x < -_cr.sw then
                del(self.cracks.list, _cr)
            end
        end
    end,

    _crack_spawner = function(self, _s)
        self.cracks.spawn_timer += 1

        if self.cracks.spawn_timer > self.cracks.next_crack then
            self.cracks.spawn_timer = 0
            self.cracks.next_crack = rnd_between(64/_s, 128/_s)
            self:_spawn_crack()
        end
    end,

    _spawn_crack = function(self)
        local _d = split(self.cracks.data[self.cracks.current], ",")
        local _y = 96

        -- if statement for 50/50 choice
        if rnd() < 0.5 then
           -- TODO: y offset to put crackt at bottom of fence
           
        end

        add(self.cracks.list, {
            x = 128,
            y = 96,
            sx = _d[1],
            sy = _d[2],
            sw = _d[3],
            sh = _d[4]
        })

        self.cracks.current += 1
        if self.cracks.current > #self.cracks.data then
            self.cracks.current = 1
        end
    end,

    _draw_crack = function(self, _cr)
        sspr(_cr.sx, _cr.sy, _cr.sw, _cr.sh, _cr.x, _cr.y)
    end


}