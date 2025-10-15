input = {
    current = {},
    previous = {},

    -- "Public" methods

    init = function(self)
        for i = 0, 5 do
            self.current[i] = false
            self.previous[i] = false
        end
    end,

    update = function(self)

        for i = 0, 5 do
            -- Store previous state
            self.previous[i] = self.current[i]
            self.current[i] = btn(i)
        end
    end,

    onpress = function(self, _b)
        return not self.previous[_b] and self.current[_b]
    end,

    onrelease = function(self, _b)
        return self.previous[_b] and not self.current[_b]
    end

}