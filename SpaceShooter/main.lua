function love.load()
	--removes mouse cursor
	love.mouse.setVisible(false)

	--sprite setup
	sprites = {}
		sprites.player = love.graphics.newImage('sprites/player.png')
		sprites.bullet = love.graphics.newImage('sprites/bullet.png')
		sprites.background = love.graphics.newImage('sprites/background.png')
		sprites.reticle = love.graphics.newImage('sprites/reticle.png')
		sprites.asteroid1 = love.graphics.newImage('sprites/asteroid1.png')
		sprites.asteroid2 = love.graphics.newImage('sprites/asteroid2.png')
		sprites.multishot = love.graphics.newImage('sprites/multishot.png')
		sprites.shieldIcon = love.graphics.newImage('sprites/shieldIcon.png')
		sprites.shieldEffect = love.graphics.newImage('sprites/shieldEffect.png')
		sprites.health = love.graphics.newImage('sprites/health.png')
		sprites.damage1 = love.graphics.newImage('sprites/damage1.png')
		sprites.damage2 = love.graphics.newImage('sprites/damage2.png')
		sprites.damage3 = love.graphics.newImage('sprites/damage3.png')
	
	success = love.window.setMode( 750, 900)

	--sound
	deathSFX = love.audio.newSource("sfx/death.ogg", "static")
	bulletSFX = love.audio.newSource("sfx/bullet.ogg", "static")
	
	--calling external scripts
	require ('asteroid')
	require ('multishot')
	require ('cooldown')
	require ('bullet')
	require ('player')
	require ('scrollingBackground')
	require ('health')
	require ('powerUp')
	
	

	--Game State Initialization
	maxTimeBetweenSpawn = 2
	spawnTimer = maxTimeBetweenSpawn

end

function love.update(dt)
	playerUpdate()
	scrollingBackgroundUpdate()
	bulletUpdate()
	multishotUpdate()
	asteroidUpdate()
	powerUpUpdate()
	cooldownUpdate()
	healthUpdate()

	spawnTimer = spawnTimer - dt
	if spawnTimer <= 0 then
		spawnbigAsteroid(math.random(0, love.graphics:getWidth()), -30, math.random(-3, 3),math.random (1, 5))
		spawnPowerUp(math.random(0, love.graphics:getWidth()), -30, math.random (1,15))
		maxTimeBetweenSpawn = maxTimeBetweenSpawn * 0.99
		spawnTimer = maxTimeBetweenSpawn
	end

end

function love.draw()
	drawScrollingBackground()
	powerUpDraw()
	drawBullet()
	drawPlayer()
	drawAsteroid()
	drawmultishot()
	drawCooldown()
	drawHealth()

	
	--draws reticle
	love.graphics.draw(sprites.reticle, love.mouse.getX(), love.mouse.getY(),nil, nil, nil, sprites.reticle:getWidth()/2, sprites.reticle:getHeight()/2)
end



































--**FUNCTIONS**

--MATH 

--finds theta angle between mouse and player (used for aiming)
function playerMouseAngleCalculation()
	-- uses trig to calculate the angle in which the player is facing the mouse
	return math.atan2(player.y - love.mouse.getY(), player.x - love.mouse.getX()) + math.pi
end

--finds theta angle between player and enemy of interest
function enemyToPlayerAngleCalculation(enemy)
	--uses trig to calculate the angle in which the bigAsteroid is facing the player
	return math.atan2(enemy.y - player.y, enemy.x - player.x) + math.pi
end

--calculates distance between to coordinates (used for collision detection)
function distanceBetween(x1,y1,x2,y2)
	--can be used to find the distance between any formula.
	return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end

