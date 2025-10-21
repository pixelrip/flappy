-- Helper functions

function log(txt)
    printh(txt, "log.p8l")
end

function draw_sprite(x,y,obj)
    local _sa = obj.sa or 0
    palt(0, false)
    palt(_sa, true)
    sspr(obj.sx, obj.sy, obj.sw, obj.sh, x, y)
    reset_pal()
end

function make_sprite(s)
    local v = split(s) or {}
    return {
        sx = v[1],
        sy = v[2],
        sw = v[3],
        sh = v[4],
        sa = v[5] or 0
    }
end

function rnd_between(min, max)
    return flr(rnd(max - min + 1) + min)
end

function print_centered(txt, y, col, outline)
    local outline = outline or ""
    local txt_width = #txt * 4
    local x = (128 - txt_width) / 2
    print(outline..txt, x, y, col)
end

function reset_pal()
    pal()
    pal( custom_palette, 1 )
end