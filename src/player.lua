player = {
    -- pos
    x = 10,
    y = 10,
    -- spr
    sx = 8, 
    sy = 0,
    sw = 8,
    sh = 8,
    -- vel
    vy = 0,

    update = function(self)
        gs:apply(self)
    end,

    draw = function(self)
        draw_sprite(self)
    end
}