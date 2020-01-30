function love.load()
	--instantiate physics
	myWorld = love.physics.newWorld(0, 500, false) --gravity: false just means physics will still apply even when it's not moving
	myWorld:setCallbacks(beginContact, endContact, preSolve, postSolve)
	
	sprites = {}
		sprites.coin_sheet = love.graphics.newImage('sprites/coin_sheet.png')
		sprites.player_jump = love.graphics.newImage('sprites/player_jump.png')
		sprites.player_stand = love.graphics.newImage('sprites/player_stand.png')
	
	--runs player script
	require ('player')
	
	platformTracker = {}
	
	spawnPlatform(50,400,300,30)
end

function love.update(dt)
	--ensures physics are updating every frame
	myWorld:update(dt)--
	playerUpdate(dt)
end

function love.draw()
	love.graphics.draw(player.sprite, player.body:getX(), player.body:getY(), nil, player.direction, 1, sprites.player_stand:getWidth()/2, sprites.player_stand:getHeight()/2)
	
	for i, p in ipairs(platformTracker) do
		love.graphics.rectangle("fill", p.body:getX(), p.body:getY(), p.width, p.height)
	end
	
	function love.keypressed (key, scancode, isrepeat)
		--jumping with physics
		if key == "up" and player.grounded == true then
			player.body:applyLinearImpulse(0, -2500)
		end
	end
end

function spawnPlatform(x, y, width, height)
	local platform = {}
		platform.body = love.physics.newBody(myWorld, x, y, "static")
		platform.shape = love.physics.newRectangleShape(width/2, height/2, width, height)
		platform.fixture = love.physics.newFixture(platform.body, platform.shape)
		platform.width = width
		platform.height = height
		
		table.insert(platformTracker, platform)
end

function beginContact(a, b, call) --checks to see when a collision begins
	player.grounded = true 
end

function endContact(a, b, call)  --checks to see when a collision ends
	player.grounded = false
end