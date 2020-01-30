--we access the player object in main.lua
player = {}
	player.body = love.physics.newBody(myWorld, 100, 100, "dynamic")
	player.shape = love.physics.newRectangleShape(66, 92)--encompasses sprite area
	player.fixture = love.physics.newFixture(player.body, player.shape)
	player.speed = 200
	
	function playerUpdate(dt)
		if love.keyboard.isDown ("right") then
			player.body:setX(player.body:getX() + player.speed * dt)
		end
		
		if love.keyboard.isDown ("left") then
			player.body:setX(player.body:getX() - player.speed * dt)
		end
	end