--we access the player object in main.lua
player = {}
	player.body = love.physics.newBody(myWorld, 100, 100, "dynamic")
	player.shape = love.physics.newRectangleShape(66, 92)--encompasses sprite area
	player.fixture = love.physics.newFixture(player.body, player.shape)