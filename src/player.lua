player = {
    -- pos
    x = 10,
    y = 60,
    -- sprite states (token inefficient but whatever)
    idle = {
        sx = 34,
        sy = 0,
        sw = 17,
        sh = 13,
        sa = 12,
    },
    wing_up = {
        sx = 0,
        sy = 0,
        sw = 17,
        sh = 13,
        sa = 12,
    },
    wing_down = {
        sx = 17,
        sy = 0,
        sw = 17,
        sh = 13,
        sa = 12,
    },
    -- vel
    vy = 0,
    -- player input state
    btn_pressed = false,

    -- animation state
    anim_state = "idle",
    anim_timer = 0,

    -- "Public" methods
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

            self.anim_state = "wing_up"
            self.anim_timer = 2 --frames
        elseif not btn(5) then
            self.btn_pressed = false
        end

        -- Apply gravity
        self.vy = min(self.vy + P_GRAVITY, P_MAX_VY_DOWN)
        self.y += self.vy

        self:_update_animation()

        -- Simple out-of-bounds check
        -- TODO: Magic numnbers; not tied to actual floor
        if self.y+13 > 121 or self.y < -13 then
            self.vy=0
            game:switch_state("game_over")
        end
    end,

    draw = function(self)
        draw_sprite(self[self.anim_state])

        -- DEBUG
        if DEBUG then
            print("vy: "..self.vy, self.x+1, self.y-10, 10)
        end
    end, 

    -- "Private" methods
    _update_animation = function(self)
        -- Handle timed animations
        if self.anim_timer > 0 then
            self.anim_timer -= 1
            return
        end

        -- Velocity-based animations
        if self.vy < 0 then
            self.anim_state = "wing_down"
        elseif self.vy > 2 then 
            self.anim_state = "wing_up"
        else
            self.anim_state = "idle"
        end
    end
}