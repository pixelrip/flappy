function _init()
	log("=== flappy started ===")
	-- custom color palette
	-- https://nerdyteachers.com/PICO-8/Palette/?c=WzAsMSwyLDE2LDQsNSw2LDcsOCw5LDE4LDE5LDEyLDEzLDE0LDIxXQ==
	poke(0x5f2e,1)
	custom_palette = {[0]=0,1,2,-16,4,5,6,7,8,9,-14,-13,12,13,14,-11}
	reset_pal()

	-- init game "modules"
	gates:init()
	clouds:init()
	mountains:init()
end

function _update()
	if game.state == "playing" then
		game:update_spike()
		clouds:update()
		mountains:update()
		player:update()
		gates:update(player)
		floor:update()
	elseif game.state == "game_over" then
		if btnp(4) then
			game:reset()
			game:switch_state("playing")
		end
	end
end

function _draw()
	cls(15)
	clouds:draw()
	mountains:draw()
	player:draw()
	gates:draw()
	floor:draw()

	print(game.score, 2, 122, 7)

	if game.state == "game_over" then
		print_centered("press 🅾️ to restart", 20, 7)
	end
end