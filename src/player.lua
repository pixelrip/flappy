player = {
    -- constants
    FLAP_STRENGTH = -3.5,
    GRAVITY = 0.1,
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
    --state
    btn_pressed = false,

    update = function(self)
        -- Check for button press
        if btn(5) and not self.btn_pressed then
            self.btn_pressed = true
            self.vy = max(-4, self.vy + self.FLAP_STRENGTH)
        elseif not btn(5) then
            self.btn_pressed = false
        end

        -- If the player is moving upwards, reduce the upward velocity slightly
        if self.vy < 0 then 
            self.vy += 0.1
        end

        -- Apply gravity
        self.vy = self.vy + self.GRAVITY
        self.y += self.vy

        -- Simple out-of-bounds check
        if self.y > 128+self.sh or self.y < 0-self.sh then
            self.y=60
            self.vy=0
        end
    end,

    draw = function(self)
        draw_sprite(self)
    end
}