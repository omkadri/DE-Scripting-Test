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
  
	--sound
	deathSFX = love.audio.newSource("sfx/death.ogg", "static")
	bulletSFX = love.audio.newSource("sfx/bullet.ogg", "static")
	
	--calling external scripts
	require ('asteroid')
	require ('bullet')
	require ('player')
	require ('scrollingBackground')

	--Game State Initialization
	gameState = 2
	maxTimeBetweenSpawn = 2
	spawnTimer = maxTimeBetweenSpawn

end

function love.update(dt)
	playerUpdate()
	scrollingBackgroundUpdate()
	bulletUpdate()
	asteroidUpdate()

	--Game State Parameters
	if gameState == 2 then
		spawnTimer = spawnTimer - dt
		if spawnTimer <= 0 then
			spawnbigAsteroid(math.random(0, love.graphics:getWidth()), -30)
			maxTimeBetweenSpawn = maxTimeBetweenSpawn * 0.97
			spawnTimer = maxTimeBetweenSpawn
		end
	end

end

function love.draw()
	drawScrollingBackground()
	drawPlayer()
	drawBullet()
	drawAsteroid()
	
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

