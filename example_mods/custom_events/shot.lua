local dodge = 0
local can = false
local val = 0

function onCreate()
	luaDebugMode = true
	makeLuaSprite('image', 'dodge', 0, 0);
	addLuaSprite('image', true);
	setObjectCamera('image', 'hud');
	setProperty('image.visible', false)

	makeLuaText('warning', 'DODGE ' .. (val) .. ' TIMES!!!', 0, 0, 0)
	setTextAlignment('warning', 'Center')
	addLuaText('warning')
	setTextSize('warning', 28)
	setProperty('warning.visible', false)

	makeLuaText('dodge', dodge .. '/' .. (val), 0, 0, 0)
	setTextAlignment('dodge', 'Center')
	addLuaText('dodge')
	setTextSize('dodge', 28)
	setProperty('dodge.visible', false)
end

function onEvent(name,value1,value2)
	if name == 'sniperShot' then
		val = value1
		if (value1) == 1 then
    	setProperty('image.visible', true)
		setProperty('warning.visible', true)
		setProperty('dodge.visible', true)
		debugPrint('sex')
		can = true
		else if (value2) == 2 then
	 	setProperty('image.visible', false)
		setProperty('warning.visible', false)
		setProperty('dodge.visible', false)
		can = false
	    if not dodge == value1 or dodge >= value1 then
			setHealth(-2)
			playAnim('boyfriend', 'hit', true);
	    else
			dodge = 0
			playAnim('boyfriend', 'dodge', true);
		end
		else if (value2) == 3 then
			 if not dodge == (value1) or dodge >= (value1) then
				setHealth(-2)
				playAnim('boyfriend', 'hit', true);
			else
				dodge = 0
				playAnim('boyfriend', 'dodge', true);
			 end
		end
	end
end
end
end

function onUpdate(elapsed)
	if can == true then
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') then
			dodge = dodge + 1
		end
	end
end