font = {

    -- make_sprite for token savings
    B = make_sprite("39,102,24,26,0"),
    I = make_sprite("63,102,24,26,0"),
    R = make_sprite("87,102,24,26,0"),
    D = make_sprite("0,80,24,26,0"),
    F = make_sprite("24,76,24,26,0"),
    L = make_sprite("48,76,24,26,0"),
    A = make_sprite("72,76,24,26,0"),
    P = make_sprite("96,76,24,26,0"),
    a = make_sprite("0,106,9,11,0"),
    m = make_sprite("9,106,12,11,0"),
    e = make_sprite("21,106,9,11,0"),
    v = make_sprite("30,106,9,11,0"),
    p = make_sprite("0,117,9,11,0"),
    r = make_sprite("9,117,9,11,0"),
    o = make_sprite("18,117,9,11,0"),
    g = make_sprite("27,117,9,11,0"),

    -- "Public" methods
    print = function(self, str, x, y)
        local chars = self:_chars(str)
        local nx = x or 0

        for c in all(chars) do
            if c == " " then
                nx += 9
            else
                local s = self[c]
                draw_sprite(nx, y, s)
                nx += s.sw + 2
            end
        end
    end,

    -- "Private" methods
    _chars = function(self, str)
        local out = {}
        for i = 1, #str do
            add(out, sub(str,i,i))
        end
        return out
    end

}
