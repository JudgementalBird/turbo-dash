--math & input shorthands
i,p = input,property
ign,igb = i.getNumber, i.getBool
pgn,pgb = p.getNumber, p.getBool

--the relevant screen library shorthands
--screen & map shorthands
s = screen
rect,rectF,line,clear,setcolor = s.drawRect,s.drawRectF,s.drawLine,s.drawClear,s.setColor

blinkstatus = false

fuelbarmax = pgn("max fuel")
rpsbarmax = pgn("max rps")
shiftbarmax = pgn("shift rps")

function beep(c,d,b)if not a then a={}a[b]={i=0}elseif not a[b]then a[b]={i=0}end;if c then if a[b].i>=d then a[b].i=0;return true else a[b].i=a[b].i+1;return false end else a[b].i=0;return false end end

c = {--color library
	sc = function(color)--inside c library because there is another setcolor that takes 3 arguments instead of table
		setcolor(color[1],color[2],color[3])
	end,
	black = {0,0,0},
	white = {255,255,255},
	gray = {7,7,7},
	darkred = {50,26,26},
	red = {255,0,0}
}

shiftindicators = {
	function(glow)
		if glow then
			c.sc(c.white)
		else
			c.sc(c.gray)
		end
		rectF(19,11,3,1)--l
		rectF(74,11,3,1)--r
	end,
	function(glow)
		if glow then
			c.sc(c.white)
		else
			c.sc(c.gray)
		end
		--l
		rectF(23,11,5,1)
		rectF(24,10,5,1)
		--r
		rectF(68,11,5,1)
		rectF(67,10,5,1)
	end,
	function(glow)
		if glow then
			c.sc(c.white)
		else
			c.sc(c.gray)
		end
		--l
		rectF(30,11,5,1)
		rectF(31,10,5,1)
		--r
		rectF(61,11,5,1)
		rectF(60,10,5,1)
	end,
	function(glow)
		if glow then
			c.sc(c.white)
		else
			c.sc(c.gray)
		end
		--l
		rectF(37,11,5,1)
		rectF(38,10,5,1)
		--r
		rectF(54,11,5,1)
		rectF(53,10,5,1)
	end,
	function(glow)
		if glow then
			c.sc(c.white)
		else
			c.sc(c.gray)
		end
		--l & r
		rectF(45,11,6,1)
		rectF(46,10,4,1)
		rectF(47,9,2,1)
	end
}
function shiftindicatorsupto(number,first,afterwards,skip)
	for k,v in ipairs(shiftindicators) do
		if type(skip) == "boolean" then
			if skip then
				shiftindicators[k](true)
			else
				shiftindicators[k](false)
			end
		else
			if k <= number then
				if first == "true" then
					shiftindicators[k](true)
				elseif first == "blink" then
					if beep(true,12,"shiftblink") then
						blinkstatus = (not blinkstatus)
					end
					shiftindicators[k](blinkstatus)
				elseif first == "false" then
					shiftindicators[k](false)
				end
			else
				if afterwards == "true" then
					shiftindicators[k](true)
				elseif afterwards == "blink" then
					if beep(true,12,"shiftblink") then
						blinkstatus = (not blinkstatus)
					end
					shiftindicators[k](blinkstatus)
				elseif afterwards == "false" then
					shiftindicators[k](false)
				end
			end
		end
	end
end

bigletters = {
	r = function(x,y)
		rectF(0+x,0+y,2,10)
		rectF(2+x,0+y,6,2)
	end,
	p = function(x,y)
		rect(0+x,0+y,7,5)
		rect(1+x,1+y,5,3)
		rectF(0+x,6+y,2,4)
	end,
	[0] = function(x,y)
		rectF(0+x,0+y,2,10)
		rectF(2+x,0+y,6,2)
		rectF(6+x,2+y,2,8)
	end,
	[1] = function(x,y)
		rectF(3+x,0+y,2,10)
	end,
	[2] = function(x,y)
		rectF(0+x,0+y,8,2)
		rectF(6+x,2+y,2,4)
		rectF(0+x,4+y,6,2)
		rectF(0+x,6+y,2,4)
		rectF(2+x,8+y,6,2)
	end,
	[3] = function(x,y)
		rectF(0+x,0+y,6,2)
		rectF(1+x,4+y,5,2)
		rectF(0+x,8+y,6,2)
		rectF(6+x,0+y,2,10)
	end,
	[4] = function(x,y)
		rectF(0+x,0+y,2,6)
		rectF(2+x,4+y,4,2)
		rectF(6+x,0+y,2,10)
	end,
	[5] = function(x,y)
		rectF(0+x,0+y,8,2)
		rectF(0+x,2+y,2,4)
		rectF(2+x,4+y,6,2)
		rectF(6+x,6+y,2,4)
		rectF(0+x,8+y,6,2)
	end,
	[6] = function(x,y)
		rectF(0+x,0+y,8,2)
		rectF(0+x,2+y,2,2)
		rect(0+x,4+y,7,5)
		rect(1+x,5+y,5,3)
	end,
	[7] = function(x,y)
		rectF(0+x,0+y,8,2)
		rectF(6+x,2+y,2,8)
	end
}

smallletters = {
	[0] = function(x,y)
		rect(0+x,0+y,3,6)
	end,
	[1] = function(x,y)
		rectF(2+x,0+y,1,7)
	end,
	[2] = function(x,y)
		rectF(0+x,0+y,4,1)
		rectF(3+x,1+y,1,3)
		rectF(0+x,3+y,3,1)
		rectF(0+x,4+y,1,3)
		rectF(1+x,6+y,3,1)
	end,
	[3] = function(x,y)
		rectF(0+x,0+y,3,1)
		rectF(0+x,3+y,3,1)
		rectF(0+x,6+y,3,1)
		rectF(3+x,0+y,1,7)
	end,
	[4] = function(x,y)
		rectF(0+x,0+y,1,4)
		rectF(1+x,3+y,2,1)
		rectF(3+x,0+y,1,7)
	end,
	[5] = function(x,y)
		rectF(0+x,0+y,4,1)
		rectF(0+x,1+y,1,3)
		rectF(1+x,3+y,3,1)
		rectF(3+x,4+y,1,3)
		rectF(0+x,6+y,3,1)
	end,
	[6] = function(x,y)
		rectF(0+x,0+y,4,1)
		rectF(0+x,1+y,1,2)
		rect(0+x,3+y,3,3)
	end,
	[7] = function(x,y)
		rectF(0+x,0+y,3,1)
		rectF(3+x,0+y,1,7)
	end,
	[8] = function(x,y)
		rect(0+x,0+y,3,3)
		rect(0+x,3+y,3,3)
	end,
	[9] = function(x,y)
		rect(0+x,0+y,3,3)
		rectF(3+x,4+y,1,3)
	end
}

dash = {
	fuelbar = function()
		--	white fuel bar gradually covering up gray bar left to right
		--	fuelbarmax || fuel
		c.sc(c.gray)
		for i = 0,2 do
			rectF(8+i,27+i,21,1)
		end
		c.sc(c.white)
		rectF(8,27,23*math.min(fuel/fuelbarmax,1),3)
		c.sc(c.black)
		rectF(8,28,1,2)
		rectF(9,29,1,1)
		rectF(29,27,2,1)
		rectF(30,28,1,1)
		--draw F
		if fuel <= fuelbarmax/10 then
			c.sc(c.red)
		else
			c.sc(c.white)
		end
		rectF(1,25,2,6)
		rectF(3,25,4,1)
		rectF(3,27,4,1)
	end,
	tempbar = function()
		--	white temperature bar gradually covering up gray bar right to left
		--	temp
		c.sc(c.gray)
		for i = 0,2 do
			rectF(67-i,27+i,21,1)
		end
		c.sc(c.white)
		rectF(88,27,-23*math.min(temp/105,1),3)
		c.sc(c.black)
		rectF(87,28,1,2)
		rectF(86,29,1,1)
		rectF(65,27,2,1)
		rectF(65,28,1,1)
		--draw T
		if temp >= 90 then
			c.sc(c.red)
		else
			c.sc(c.white)
		end
		rectF(91,25,2,6)
		rectF(89,25,6,1)
	end,
	rpsbar = function()
		--	white&red rps bar gradually covering up gray&dark red bar left to right, blink when all the way  to the right
		--	rpsbarmax || rps
		--gray background boxes
		c.sc(c.gray)
		rectF(10,3,65,5)
		--red end box
		c.sc(c.darkred)
		rectF(76,3,10,5)
		--red part of bar
		c.sc(c.red)
		rectF(10,3,76*math.min(rps/rpsbarmax,1),5)
		--white part of bar drawn on top of red bar
		c.sc(c.white)
		rectF(10,3,math.min(76*math.min(rps/rpsbarmax,1),66),5)
		--lines to form the boxes
		c.sc(c.black)
		for i = 0,6 do
			rectF(20+(i*11),3,1,5)
		end
	end,
	shiftindicator = function()
		--	white segments closing in left and right to middle with different rps range to rpsbar
		--	shiftbarmax || rps
		--	not dry :sob:
		
		if rps >= shiftbarmax then
			shiftindicatorsupto(4,"true","blink")--true up to ind 4 then blink
		elseif rps >= (shiftbarmax/6)*5 then
			shiftindicatorsupto(0,"","",true)--all true
		elseif rps >= (shiftbarmax/6)*4 then
			shiftindicatorsupto(4,"true","false")--true up to ind 4 then false
		elseif rps >= (shiftbarmax/6)*3 then
			shiftindicatorsupto(3,"true","false")--true up to ind 3 then false
		elseif rps >= (shiftbarmax/6)*2 then
			shiftindicatorsupto(2,"true","false")--true up to ind 2 then false
		elseif rps >= (shiftbarmax/6)*1 then
			shiftindicatorsupto(1,"true","false")--true up to ind 1 then false
		else
			shiftindicatorsupto(0,"","",false)--all false
		end
	end,
	gearindicator = function()
		--	white custom font 1 digit number R, N, 1,2,etc for the gear the car is in
		--	gear | parkbrake
		c.sc(c.white)
		if parkbrake then
			bigletters.p(44,13)
		elseif reverse then
			bigletters.r(44,13)
		else
			bigletters[gear](44,13)
		end
		
	end,
	kmhindicator = function()
		--	white custom font 3 digit number for speed kmh
		--	speedms
		speedkmh = speedms*3.6
		informativenameforthisvariable = {}
		for i = 1,3 do
			informativenameforthisvariable[i] = tonumber(string.sub(tostring(speedkmh),i,i))
		end
		smallletters[informativenameforthisvariable[1] or 0](41,24)
		smallletters[informativenameforthisvariable[2] or 0](46,24)
		smallletters[informativenameforthisvariable[3] or 0](51,24)
	end
}

function onTick()
	fuel = ign(1)
	temp = ign(2)
	rps = ign(3)
	gear = ign(4)
	speedms = ign(5)

	parkbrake = igb(1)
	reverse = igb(2)
end

function onDraw()
	dash.fuelbar()
	dash.tempbar()
	dash.rpsbar()
	dash.shiftindicator()
	dash.gearindicator()
	dash.kmhindicator()
	--[[ ruler to debug positions
	c.sc(c.white)
	for i = 0,96,2 do
		rectF(i,0,1,1)
	end
	]]
end