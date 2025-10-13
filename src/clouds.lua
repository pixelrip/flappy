clouds = {
    data = {
        "51,0,20,12",
        "71,0,15,8",
        "88,0,12,8",
        "100,0,28,10",
        "51,12,20,10",
        "71,28,23,14",
        "94,10,34,12"
    },
    data_len = 7,
    current_cloud = 1,
    list = {},
    spawn_timer = 0,
    next_cloud = 0,

    -- "Public" methods

    init = function(self)
        -- TODO: 2 initial clouds
    end,

    update = function(self)
        local _s = game:get_speed()/12

        self:_move_clouds(_s)
        self:_cloud_spawner(_s)
    end,

    draw = function(self)
        for _cl in all(self.list) do
            self:_draw_cloud(_cl)
        end
    end,

    reset = function(self)
        self.list = {}
        self.spawn_timer = 0
    end,

    -- "Private" methods
    
    _move_clouds = function(self, _s)
        for _cl in all(self.list) do
            _cl.x -= _s

            if _cl.x < -_cl.sw then
                del(self.list, _cl)
            end
        end
    end,

    _cloud_spawner = function(self, _s)
        self.spawn_timer += 1

        if self.spawn_timer > self.next_cloud then
            self.spawn_timer = 0
            self.next_cloud = rnd_between(64/_s, 128/_s)
            self:_spawn_cloud()
        end
    end,

    _spawn_cloud = function(self)
        local _d = split(self.data[self.current_cloud], ",")

        add(self.list, {
            x = 128,
            y = rnd_between(0, 64),
            sx = _d[1],
            sy = _d[2],
            sw = _d[3],
            sh = _d[4]
        })

        self.current_cloud += 1
        if self.current_cloud > self.data_len then
            self.current_cloud = 1
        end
    end,

    _draw_cloud = function(self, _cl)
        sspr(_cl.sx, _cl.sy, _cl.sw, _cl.sh, _cl.x, _cl.y)
    end
}