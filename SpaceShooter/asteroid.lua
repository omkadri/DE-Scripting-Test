bigAsteroidTracker = {}

smallAsteroidTracker = {}

function spawnbigAsteroid(x, y)
	bigAsteroid = {}
		bigAsteroid.x = x
		bigAsteroid.y = y
		bigAsteroid.speed = 100
		bigAsteroid.offsetX = sprites.asteroid1:getWidth()/2
		bigAsteroid.offsetY = sprites.asteroid1:getHeight()/2--center bigAsteroid pivot point
		bigAsteroid.despawn = false	
		
		
	table.insert(bigAsteroidTracker, bigAsteroid)--adds this bigAsteroid table to the bigAsteroidTracker table in love.load()
end

function spawnSmallAsteroid(x, y, dir)
	smallAsteroid = {}
		smallAsteroid.x = x
		smallAsteroid.y = y
		smallAsteroid.direction = dir
		smallAsteroid.speed = 150
		smallAsteroid.offsetX = sprites.asteroid2:getWidth()/2
		smallAsteroid.offsetY = sprites.asteroid2:getHeight()/2--center bigAsteroid pivot point
		smallAsteroid.despawn = false	
		
	table.insert(smallAsteroidTracker, smallAsteroid)--adds this bigAsteroid table to the bigAsteroidTracker table in love.load()
end