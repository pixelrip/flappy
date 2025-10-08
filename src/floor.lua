floor = {
    x_offset = 0,

    --sprite
    sx = 0,
    sy = 16,
    sw = 10,
    sh = 8,
    sa = 15,

    update = function(self)
        local _s = game:get_speed()
        self.x_offset -= _s
        if self.x_offset <= -10 then
            self.x_offset = 0
        end
    end,

    draw = function(self)
        for i = 0, 130, 10 do
            draw_sprite({
                x = i + self.x_offset,
                y = 120,
                sx = self.sx,
                sy = self.sy,
                sw = self.sw,
                sh = self.sh,
                sa = self.sa
            })
        end
    end
}