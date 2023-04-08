function onCreate()
	-- background shit
	makeLuaSprite('2fortStage', '2fortStage', -350, -150);
	setScrollFactor('2fortStage', 0.9, 0.9);
	scaleObject('2fortStage', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeAnimatedLuaSprite('tf2DanceTitle', 'tf2DanceTitle', 900, 100)
        addAnimationByPrefix('tf2DanceTitle', 'tf2DanceTitle', 'tf2DanceTitle', 24, false);
    	setScrollFactor('tf2DanceTitle', 0.9, 0.9);
    	--scaleObject('tf2DanceTitle', 0.7, 0.7);
		makeAnimatedLuaSprite('tf2DanceTitleShock', 'tf2DanceTitleShock', 900, 100)
        addAnimationByPrefix('tf2DanceTitleShock', 'tf2DanceTitleShock', 'tf2DanceTitle', 24, true);
    	setScrollFactor('tf2DanceTitleShock', 0.9, 0.9);
	end

	addLuaSprite('2fortStage', false);
	addLuaSprite('tf2DanceTitle', false);
	if songName:lower() == 'scout-rage' then
		removeLuaSprite('tf2DanceTitle', true)
	end
	
	--close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end

function onBeatHit()
	if curBeat % 2 == 0 then
		dance();
	end
end

function dance()
	playAnim('tf2DanceTitle', 'tf2DanceTitle', true);
end

function onEvent(eventName, value1, value2)
	if eventName == 'Change Character' then
		if value2 == 'red-spy-v3' then
	    	removeLuaSprite('tf2DanceTitle', true)
			addLuaSprite('tf2DanceTitleShock', false);
     	end
	end
end