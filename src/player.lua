player = {
    -- constants
    FLAP_STRENGTH = -3.5,
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
        if btnp(4) then
            if self.vy < 0 then return end
            self.vy += self.FLAP_STRENGTH
        end

        if self.vy < 0 then 
            self.vy += 0.1
        end

        gs:apply(self)
    end,

    draw = function(self)
        draw_sprite(self)
    end
}