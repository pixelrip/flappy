player = {
    -- constants
    FLAP_STRENGTH = -3.5,
    GRAVITY = 0.1,
    START_X = 10,
    START_Y = 60,
    MAX_UP_VELOCITY = -4,
    -- pos
    x = 10,
    y = 60,
    -- spr
    sx = 8, 
    sy = 0,
    sw = 8,
    sh = 8,
    -- vel
    vy = 0,
    --state
    btn_pressed = false,

    reset = function(self)
        self.x = self.START_X
        self.y = self.START_Y
        self.vy = 0
        self.btn_pressed = false
    end,

    update = function(self)
        -- Check for button press
        if btn(5) and not self.btn_pressed then
            self.btn_pressed = true
            self.vy = max(self.MAX_UP_VELOCITY, self.vy + self.FLAP_STRENGTH)
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

            game:switch_state("game_over")
        end
    end,

    draw = function(self)
        draw_sprite(self)
    end
}