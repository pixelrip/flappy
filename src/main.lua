function _init()
	log("=== flappy started ===")
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
	cls(12)
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