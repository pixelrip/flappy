buildings = {

    -- FIX: Theres gotta be a better way to do this
    layers = {},

    -- "Public" methods

    init = function(self)

        -- Create building layers
        add(self.layers, {
            buildings = {},
            speed = game:get_speed()/6,
            color = 2,
            cap_max = 0,
            cap_min = 0,
            size_max = 60,
            size_min = 50,
            offset = true
        })

        add(self.layers, {
            buildings = {},
            speed = game:get_speed()/4,
            color = 13,
            cap_max = 16,
            cap_min = 8,
            size_max = 64,
            size_min = 48,
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
        self:init()
    end,


    -- "Private" methods

    _init_layer = function(self, layer)
        for i = 0, 3 do
            local _size = rnd_between(layer.size_min, layer.size_max)
            local _x = i * flr(_size * 1.55)

            if layer.offset and i == 0 then
                _x += _size/2
            end

            -- TODO: DRY this up with _update_layer
            add(layer.buildings, {
                x = _x,
                size = _size,
                cap = rnd_between(layer.cap_min, layer.cap_max),
                color = layer.color,
            })
        end
    end,

    _update_layer = function(self, layer)
        -- Move all buildings
        for building in all(layer.buildings) do
            building.x -= layer.speed
        end

        -- Check if leftmost building is off screen
        local leftmost = layer.buildings[1]

        if leftmost.x and leftmost.x < -leftmost.size * 2 then
            -- Remove leftmost building
            del(layer.buildings, leftmost)

            -- Add new building to the right
            local rightmost = layer.buildings[#layer.buildings]
            local _size = rnd_between(layer.size_min, layer.size_max)
            local _x = rightmost.x + flr(rightmost.size * 1.75)

            -- TODO: DRY this up with _init_layer
            add(layer.buildings, {
                x = _x,
                size = _size,
                cap = rnd_between(layer.cap_min, layer.cap_max),
                color = layer.color,
            })
        end

    end,

    _draw_building = function(self, opts)
        opts = opts or {}
        local _size = opts.size or 42
        local _x = opts.x or 0
        local _cap = opts.cap or 0
        local _color = opts.color or 13

        for i = 0, _size do
            local _lx = _x + i
            local _rx = _x + (_size * 2 - i)
            local _y0 = 128 - i
            local _y1 = 128

            -- Draw building sides
            line(_lx, _y0, _lx, _y1, _color)
            line(_rx, _y0, _rx, _y1, _color)

            -- Draw snow cap
            if _size - i < _cap then
                local _ny0 = _y0 + 1
                local _ny1 = 128 - _size + _cap

                line(_lx, _ny0, _lx, _ny1, 7)
                line(_rx, _ny0, _rx, _ny1, 7)
            end
        end
    end,
}