gs = {
    GRAVITY = 0.1
}

function gs:apply(o)
    if o.vy and o.y then
        o.vy = o.vy + self.GRAVITY
        o.y += o.vy
    end
end