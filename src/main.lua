function _init()
	log("=== flappy started ===")
	gates:init()
end

function _update()
	if game.state == "playing" then
		player:update()
		gates:update()
	elseif game.state == "game_over" then
		if btnp(4) then
			game:reset()
			game:switch_state("playing")
		end
	end
end

function _draw()
	cls(1)
	player:draw()
	gates:draw()

	print(game.score, 2, 122, 7)
end