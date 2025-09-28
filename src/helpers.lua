-- Helper functions

function log(txt)
    printh(txt, "log.p8l")
end

function draw_sprite(obj)
    sspr(obj.sx, obj.sy, obj.sw, obj.sh, obj.x, obj.y)
end