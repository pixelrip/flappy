player = {
    -- pos
    x = 10,
    y = 60,
    -- sprite states
    sprite ={
        idle = make_sprite("0,15,19,15,12"),
        wing_up = make_sprite("0,0,19,15,12"),
        wing_down = make_sprite("19,0,19,15,12"),
    },
    
    -- vel
    vy = 0,

    -- hitbox
    hitbox = {
        x_off = 5,
        y_off = 3,
        w = 9,
        h = 10,
    },

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
            self.anim_timer = 1 --frames 
            sfx(0) -- flap sound
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
            switch_state(states.game_over)
        end
    end,

    draw = function(self)
        draw_sprite(self.x, self.y, self.sprite[self.anim_state])

        -- DEBUG
        if DEBUG then
            print("vy: "..self.vy, self.x+1, self.y-10, 10)
            self:_draw_hitbox()
        end
    end, 

    get_bounds = function(self)
        return {
            x1 = self.x + self.hitbox.x_off,
            y1 = self.y + self.hitbox.y_off,
            x2 = self.x + self.hitbox.x_off + self.hitbox.w,
            y2 = self.y + self.hitbox.y_off + self.hitbox.h,
        }
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
    end,

    _draw_hitbox = function(self)
        local b = self:get_bounds()
        rect(b.x1, b.y1, b.x2, b.y2, 10)
    end,
}