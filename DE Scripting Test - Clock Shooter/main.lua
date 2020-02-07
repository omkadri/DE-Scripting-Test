

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
	powerUpSFX = love.audio.newSource("sfx/powerUp.ogg", "static")
	
	--calling external scripts
	require ('bullet')
	require ('asteroid')
	require ('multishot')
	require ('cooldown')
	require ('player')
	require ('scrollingBackground')
	require ('health')
	require ('powerUp')
	
	

	--Game State Initialization
	currentScore = 0
	maxTimeBetweenAsteroidSpawn = 2
	asteroidSpawnTimer = maxTimeBetweenAsteroidSpawn
	
	maxTimeBetweenPowerUpSpawn = 2
	powerUpSpawnTimer = maxTimeBetweenPowerUpSpawn

end

function love.update(dt)
	love.window.setTitle("Omar Kadri - DE Scripting Test")
	grabMouse = love.mouse.setGrabbed(true)
	
	playerUpdate()
	scrollingBackgroundUpdate()
	bulletUpdate()
	multishotUpdate()
	asteroidUpdate()
	powerUpUpdate()
	cooldownUpdate()
	healthUpdate()

	asteroidSpawnTimer = asteroidSpawnTimer - dt
	if asteroidSpawnTimer <= 0 then
		spawnbigAsteroid(math.random(0, love.graphics:getWidth()), -30, math.random(-3, 3),math.random (1, 5))
		maxTimeBetweenAsteroidSpawn = maxTimeBetweenAsteroidSpawn * 0.99
		asteroidSpawnTimer = maxTimeBetweenAsteroidSpawn
	end
	
	powerUpSpawnTimer = powerUpSpawnTimer - dt
	if powerUpSpawnTimer <= 0 then
		spawnPowerUp(math.random(0, love.graphics:getWidth()), -30, math.random (1,15))
		powerUpSpawnTimer = maxTimeBetweenPowerUpSpawn
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
	love.graphics.print(currentScore, 700, 10)

	
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

