function _init()
	log("\n\n\n=== flappy started ===")
	-- custom color palette
	-- https://nerdyteachers.com/PICO-8/Palette/?c=WzAsMSwyLDE2LDQsNSw2LDcsOCw5LDE4LDE5LDEyLDEzLDE0LDIxXQ==
	poke(0x5f2e,1)
	custom_palette = {[0]=0,1,2,-16,4,5,6,7,8,9,-14,-13,12,13,14,-11}
	reset_pal()

	save:init()
	save:load_all()
	input:init()
	switch_state(states.title)
end

function _update()
	input:update()
	if current_state and current_state.update then
		current_state:update()
	end
end

function _draw()
	if current_state and current_state.draw then
		current_state:draw()
	end
end