local vallol = 0
local dodge = 0
local can = false

function onCreate()
	luaDebugMode = true
	makeLuaSprite('image', 'dodge', 270, 200);
	addLuaSprite('image', true);
	setObjectCamera('image', 'hud');
	setProperty('image.visible', false)

	makeLuaText('warning', 'DODGE ' .. 0 .. ' TIMES!!!', 0, 270, 400)
	setTextAlignment('warning', 'Center')
	addLuaText('warning')
	setTextSize('warning', 69)
	setProperty('warning.visible', false)

	makeLuaText('dodge', dodge .. '/' .. 0, 0, 500, 480)
	setTextAlignment('dodge', 'Center')
	addLuaText('dodge')
	setTextSize('dodge', 48)
	setProperty('dodge.visible', false)
end

function onEvent(name,value1,value2)
	if name == 'sniperShot' then

		if value1 == "1" then
			vallol = 1
		end

		if value1 == "2" then
			vallol = 2
		end

		if value1 == "3" then
			vallol = 3
		end

		setTextString('warning', 'DODGE ' .. vallol .. ' TIMES!!!');
		setTextString('dodge', dodge .. '/' .. vallol);
		if value2 == "1" then
    	setProperty('image.visible', true)
		setProperty('warning.visible', true)
		setProperty('dodge.visible', true)
		can = true
		dodge = 0
		else if value2 == "2" then
	 	setProperty('image.visible', false)
		setProperty('warning.visible', false)
		setProperty('dodge.visible', false)
	    if vallol == dodge or botPlay then
			cameraShake('camGame', 0.02, 0.2)
			playAnim('boyfriend', 'dodge', true);
			setProperty('boyfriend.specialAnim', true);
			can = false
			addHealth(0.2)
	    else
			cameraShake('camGame', 0.02, 0.2)
			addHealth(-0.8)
			playAnim('boyfriend', 'hit', true);
			setProperty('boyfriend.specialAnim', true);
		end
	end
end
end
end

function onUpdate(elapsed)
	if can then
		setTextString('dodge', dodge .. '/' .. vallol);
		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') then
			dodge = dodge + 1
		end
	end
end