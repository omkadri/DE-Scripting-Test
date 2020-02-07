function love.load()
end

function love.update(dt)
	getCoordinatesFromThetaAngles()
	SetClockTansform (100, 100, 100)
end

function love.draw()
	
	drawClock()
end


-- **FUNCTIONS**



--INITIALIZATION
function SetClockTansform(x, y, size)
	enemyClock = {}
		enemyClock.x = x
		enemyClock.y = y
		enemyClock.radius = size
		--These next lines calculate the XY coordinate data for the terminal ends of each clock hand.
		--Terminal End of hour hand
		enemyClock.hourHandX = (math.sin(thetaAngleForHours)*(enemyClock.radius*0.3) + enemyClock.x)
		enemyClock.hourHandY = (math.cos(thetaAngleForHours)*(enemyClock.radius*0.3) + enemyClock.y)

		--Terminal End of minute hand
		enemyClock.minuteHandX = (math.sin(thetaAngleForMinutes)*(enemyClock.radius*0.60) + enemyClock.x)
		enemyClock.minuteHandY = (math.cos(thetaAngleForMinutes)*(enemyClock.radius*0.60) + enemyClock.y)
		
		--Terminal End of second hand
		enemyClock.SecondHandX = (math.sin(thetaAngleForSeconds)*(enemyClock.radius*0.75) + enemyClock.x)
		enemyClock.SecondHandY = (math.cos(thetaAngleForSeconds)*(enemyClock.radius*0.75) + enemyClock.y)
end


--TRIGONOMETRY
function thetaAngleCalculator (currentTimeParameter, totalTimescale)
	
	theta = (currentTimeParameter / totalTimescale) * (2*math.pi) * (-1) + math.pi
    --multiplying by (-1) makes the hand tick clockwise, and adding math.pi makes the hand start at the top

	return theta
    --example: to find the theta angle for the clock's minute hand, we would call thetaAngleCalculator (os.date("%M"), 60)
end

function getCoordinatesFromThetaAngles()
	
	thetaAngleForHours = thetaAngleCalculator (os.date("%I"), 12)
    thetaAngleForMinutes = thetaAngleCalculator (os.date("%M"), 60)
    thetaAngleForSeconds = thetaAngleCalculator (os.date("%S"), 60)
	

end


--DRAWING
function drawClock()
		
	--sets font to be proportionate
	clockFont = love.graphics.newFont(enemyClock.radius / 4, center)

	--clock outline and appearence
    love.graphics.setColor(0.5,0.5,0.5)
    love.graphics.circle("fill", enemyClock.x, enemyClock.y, enemyClock.radius)
    love.graphics.setColor(1,1,1)
    love.graphics.circle("line", enemyClock.x, enemyClock.y, enemyClock.radius)
    love.graphics.circle("line", enemyClock.x, enemyClock.y, enemyClock.radius)

	--clock numbers
    love.graphics.setColor(0,0,0)
    love.graphics.setFont(clockFont)
    love.graphics.print("3", (enemyClock.x+(enemyClock.radius*0.75)), enemyClock.y - 7)
    love.graphics.print("6", enemyClock.x - 7, (enemyClock.y+(enemyClock.radius*0.75)))
    love.graphics.print("9", (enemyClock.x-(enemyClock.radius*0.9)), enemyClock.y - 8 )
    love.graphics.print("12", enemyClock.x - 11, (enemyClock.y-(enemyClock.radius*0.9)))

    --Coordinating each of the hands
		--Seconds Hand
    love.graphics.setColor(0,0,1)
    love.graphics.line(enemyClock.x,enemyClock.y, enemyClock.SecondHandX,enemyClock.SecondHandY)--blue line(seconds)
    love.graphics.circle("fill", enemyClock.SecondHandX, enemyClock.SecondHandY, 3) --terminalEnd of Hour hand
	
		--Minute Hand
    love.graphics.setColor(1,0,0)
    love.graphics.line(enemyClock.x,enemyClock.y, enemyClock.minuteHandX,enemyClock.minuteHandY)--red line (minutes)
    love.graphics.circle("fill", enemyClock.minuteHandX, enemyClock.minuteHandY, 3) --terminalEnd of Hour hand

		--Hour Hand
    love.graphics.setColor(0,1,0)
    love.graphics.line(enemyClock.x,enemyClock.y, enemyClock.hourHandX,enemyClock.hourHandY)--green line (hours)
    love.graphics.circle("fill", enemyClock.hourHandX, enemyClock.hourHandY, 3) --terminalEnd of Hour hand

    --circle in center of clock
    love.graphics.setColor(0.1,0.1,0.1)
    love.graphics.circle("fill", enemyClock.x, enemyClock.y, 5)
	
	--reset color data to default
	love.graphics.setColor(255,255,255)
end

function drawDebugger()
  if love.keyboard.isDown("i") then
    debuggerX = 250
    debuggerY = 0
    love.graphics.setColor(0,1,0)
    love.graphics.setNewFont(15)
    love.graphics.print("Debug Info:",debuggerX,debuggerY)
    love.graphics.setColor(1,1,1)
    love.graphics.print("Current Date/Time: "..currentTime.fullTime,debuggerX,debuggerY + 25)
    love.graphics.print("Current Hour: "..currentTime.hour,debuggerX,debuggerY + 50)
    love.graphics.print("Current Minute: "..currentTime.minute,debuggerX,debuggerY + 75)
    love.graphics.print("Current Second: "..currentTime.second,debuggerX,debuggerY + 100)
    love.graphics.print("Theta Angle For Hour Hand: "..thetaAngleForHours,debuggerX,debuggerY + 125)
    love.graphics.print("Theta Angle For Minute Hand: "..thetaAngleForMinutes,debuggerX,debuggerY + 150)
    love.graphics.print("Theta Angle For Second Hand: "..thetaAngleForSeconds,debuggerX,debuggerY + 175)
    love.graphics.print("Clock Radius: "..enemyClock.radius,debuggerX,debuggerY + 200)
    love.graphics.print("Terminal End Coordinate for Hour: ("..enemyClock.hourHandX..", "..enemyClock.hourHandY..")",debuggerX,debuggerY + 225)
    love.graphics.print("Terminal End Coordinate for Minute: ("..enemyClock.minuteHandX..", "..enemyClock.minuteHandY..")",debuggerX,debuggerY + 250)
    love.graphics.print("Terminal End Coordinate for Second: ("..enemyClock.SecondHandX..", "..enemyClock.SecondHandY..")",debuggerX,debuggerY + 275)
    love.graphics.print("enemyClock.x: "..enemyClock.x,debuggerX,debuggerY + 300)
    love.graphics.print("enemyClock.y: "..enemyClock.y,debuggerX,debuggerY + 325)
  end
end


--***Written by Omar Kadri***