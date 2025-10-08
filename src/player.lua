player = {
    -- pos
    x = 10,
    y = 60,
    -- spr
    sx = 34, 
    sy = 0,
    sw = 17,
    sh = 13,
    sa = 12,
    -- vel
    vy = 0,
    --state
    btn_pressed = false,

    reset = function(self)
        self.x = P_START_X
        self.y = P_START_Y
        self.vy = 0
        self.btn_pressed = false
    end,

    update = function(self)
        -- Check for button press
        if btn(5) and not self.btn_pressed then
            self.btn_pressed = true
            self.vy = max(P_MAX_VY_UP, self.vy + P_FLAP)
        elseif not btn(5) then
            self.btn_pressed = false
        end

        -- Apply gravity
        self.vy = min(self.vy + P_GRAVITY, P_MAX_VY_DOWN)
        self.y += self.vy

        -- Simple out-of-bounds check
        -- TODO: Magic numnbers; not tied to actual floor
        if self.y+self.sh > 121 or self.y < 0-self.sh then
            self.vy=0
            game:switch_state("game_over")
        end
    end,

    draw = function(self)
        draw_sprite(self)

        -- DEBUG
        if DEBUG then
            print("vy: "..self.vy, self.x+1, self.y-10, 10)
        end
    end
}