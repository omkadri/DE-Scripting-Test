--we access the player object in main.lua
player = {}
	player.body = love.physics.newBody(myWorld, 100, 100, "dynamic")
	player.shape = love.physics.newRectangleShape(66, 92)--encompasses sprite area
	player.fixture = love.physics.newFixture(player.body, player.shape)
	player.speed = 200
	player.grounded = false
	player.direction = 1
	player.sprite = sprites.player_stand
	player.body:setFixedRotation(true)--stops player from faliing off of edge(tilt perevention)
	
	function playerUpdate(dt)
		if love.keyboard.isDown ("right") then
			player.body:setX(player.body:getX() + player.speed * dt)
			player.direction = 1
		end
		
		
		
		if love.keyboard.isDown ("left") then
			player.body:setX(player.body:getX() - player.speed * dt)
			player.direction = -1
		end
		
		if player.grounded == true then
			player.sprite = sprites.player_stand
		else 
			player.sprite = sprites.player_jump
		end
	end