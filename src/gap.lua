gap = {
    -- first gap
    x = 128,
    y = 44,
    h = 40,
    w = 30,

    update = function(self)
        self.x -= 1
        if self.x < -self.w then
            self.x = 128
            self.y = rnd_between(20, 80)
            self.w = rnd_between(20, 40)
            self.h = rnd_between(30, 50)
        end
    end,

    draw = function(self)
        -- RRECTFILL(X, Y, W, H, R, [COL])
        -- Top Pipe
        rrectfill(self.x,0,self.w,self.y,0,3)
        -- Bottom Pipe
        rrectfill(self.x,self.y+self.h,self.w,128,0,3)
    end
}

