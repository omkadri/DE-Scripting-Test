function love.load()
	--initial clock transform data. This can be changed by using SetClockTansform()
	enemyClock = {}
		enemyClock.x = 100
		enemyClock.y = 100
		enemyClock.radius = 100
		enemyClock.speed = 500
end

function love.update(dt)
	runTrigFunctions()
end

function love.draw()
	drawClock()
    drawDebugger()
end



-- **FUNCTIONS**

--initialization
function GetCurrentTimeData()
	--creating table for getting time data from OS
    currentTime = {}
		currentTime.fullTime = os.date()
		currentTime.hour = os.date("%I") --based on 12 hour clock
		currentTime.minute = os.date("%M")
		currentTime.second = os.date("%S")
end

function SetClockTansform(x, y, size)
	enemyClock.x = x
	enemyClock.y = y
	enemyClock.radius = size
end


--trigonometric functions
function thetaAngleCalculator (currentTimeParameter, totalTimescale)
	
	theta = (currentTimeParameter / totalTimescale) * (2*math.pi) * (-1) + math.pi
    --multiplying by (-1) makes the hand tick in the right direction, and adding math.pi makes the hand start at the top

	return theta
    --example: to find the theta angle for the clock's minute hand, we would call thetaAngleCalculator (currentTime.minute, 60)
end

function GetThetaAngles()
	thetaAngleForHours = thetaAngleCalculator (currentTime.hour, 12)
    thetaAngleForMinutes = thetaAngleCalculator (currentTime.minute, 60)
    thetaAngleForSeconds = thetaAngleCalculator (currentTime.second, 60)
end

function GetTerminalEndCoordinates()
    --This function calculates the coordinate data for the terminal ends of each clock hand.

    --Terminal End of hour hand
    terminalEndHourX = (math.sin(thetaAngleForHours)*(enemyClock.radius*0.3) + enemyClock.x)
    terminalEndHourY = (math.cos(thetaAngleForHours)*(enemyClock.radius*0.3) + enemyClock.y)

    --Terminal End of minute hand
    terminalEndMinuteX = (math.sin(thetaAngleForMinutes)*(enemyClock.radius*0.60) + enemyClock.x)
    terminalEndMinuteY = (math.cos(thetaAngleForMinutes)*(enemyClock.radius*0.60) + enemyClock.y)
	
	--Terminal End of second hand
    terminalEndSecondX = (math.sin(thetaAngleForSeconds)*(enemyClock.radius*0.75) + enemyClock.x)
    terminalEndSecondY = (math.cos(thetaAngleForSeconds)*(enemyClock.radius*0.75) + enemyClock.y)
end

function runTrigFunctions()
	--setting clock position and size data
	GetCurrentTimeData()
	--trigonometry
	GetThetaAngles()
	GetTerminalEndCoordinates()
end
--drawing
function drawClock()

	--grab default color data
	r, g, b, a = love.graphics.getColor( )
	
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
    love.graphics.line(enemyClock.x,enemyClock.y, terminalEndSecondX,terminalEndSecondY)--blue line(seconds)
    love.graphics.circle("fill", terminalEndSecondX, terminalEndSecondY, 3) --terminalEnd of Hour hand
	
		--Minute Hand
    love.graphics.setColor(1,0,0)
    love.graphics.line(enemyClock.x,enemyClock.y, terminalEndMinuteX,terminalEndMinuteY)--red line (minutes)
    love.graphics.circle("fill", terminalEndMinuteX, terminalEndMinuteY, 3) --terminalEnd of Hour hand

		--Hour Hand
    love.graphics.setColor(0,1,0)
    love.graphics.line(enemyClock.x,enemyClock.y, terminalEndHourX,terminalEndHourY)--green line (hours)
    love.graphics.circle("fill", terminalEndHourX, terminalEndHourY, 3) --terminalEnd of Hour hand

    --circle in center of clock
    love.graphics.setColor(0.1,0.1,0.1)
    love.graphics.circle("fill", enemyClock.x, enemyClock.y, 5)
	
	--reset color data to default
	love.graphics.setColor(r,g,b)
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
    love.graphics.print("Terminal End Coordinate for Hour: ("..terminalEndHourX..", "..terminalEndHourY..")",debuggerX,debuggerY + 225)
    love.graphics.print("Terminal End Coordinate for Minute: ("..terminalEndMinuteX..", "..terminalEndMinuteY..")",debuggerX,debuggerY + 250)
    love.graphics.print("Terminal End Coordinate for Second: ("..terminalEndSecondX..", "..terminalEndSecondY..")",debuggerX,debuggerY + 275)
    love.graphics.print("enemyClock.x: "..enemyClock.x,debuggerX,debuggerY + 300)
    love.graphics.print("enemyClock.y: "..enemyClock.y,debuggerX,debuggerY + 325)
  end
end


--***Written by Omar Kadri***