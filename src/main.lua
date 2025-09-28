function _init()
	log("=== flappy started ===")
end

function _update()
	player:update()
end

function _draw()
	cls(1)
	player:draw()
	
end