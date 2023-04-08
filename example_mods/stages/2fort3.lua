local sex = false

function onCreate()
	-- background shit
	makeLuaSprite('2fortStage', 'thirdStage', -350, -150);
	setScrollFactor('2fortStage', 0.9, 0.9);
	scaleObject('2fortStage', 1.1, 1.1);

	-- sprites that only load if Low Quality is turned off
		makeAnimatedLuaSprite('tf2DanceTitle', 'characters/Heavy-lol', 200, 300)
        addAnimationByPrefix('tf2DanceTitle', 'dance', 'idle', 24, false);
		addAnimationByPrefix('tf2DanceTitle', 'ready', 'startShot', 24, false);
		addAnimationByPrefix('tf2DanceTitle', 'shot', 'shooting', 24, true);
		scaleObject('tf2DanceTitle', 0.5, 0.5); 
    	setScrollFactor('tf2DanceTitle', 0.9, 0.9);
    	--scaleObject('tf2DanceTitle', 0.7, 0.7);
		makeAnimatedLuaSprite('Medic', 'MedicHealer', -200, 100)
        addAnimationByPrefix('Medic', 'dance', 'Idle medic', 24, false);
		addAnimationByPrefix('Medic', 'heal', 'Heal', 24, false);
		scaleObject('Medic', 0.8, 0.8); 
    	setScrollFactor('Medic', 0.9, 0.9);

	addLuaSprite('2fortStage', false);
	addLuaSprite('tf2DanceTitle', false);
	addLuaSprite('Medic', true);
	if songName:lower() == 'rage-quit' then
		removeLuaSprite('tf2DanceTitle', false);
		removeLuaSprite('Medic', true);
	end
	
	--close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end

function onBeatHit()
	if curBeat % 2 == 0 then
		dance();
	end
end

function dance()
	if sex == false then
	playAnim('tf2DanceTitle', 'dance', true);
end
	playAnim('Medic', 'dance', true);
end

function onEvent(eventName, value1, value2)
	if eventName == 'Change Character' then
		if value2 == 'sniperBlu' or value2 == 'medicBlu' or value2 == 'heavyBlu' then
			setProperty('Medic.alpha', 0.0001)
			setProperty('tf2DanceTitle.alpha', 0.0001)
     	else
			setProperty('Medic.alpha', 1)
			setProperty('tf2DanceTitle.alpha', 1)			
		end
	end
	if eventName == 'doc' then
		playAnim('Medic', 'heal', true);
		playSound('medicHit'.. getRandomInt(1, 3), 0.3)
	end
	if eventName == 'heavy' then
		if value1 == "3" then
			playAnim('tf2DanceTitle', 'ready', true);
			if getProperty('dad.curCharacter') == 'heavyBlu' then
				playAnim('dad', 'ready', true);
				setProperty('dad.specialAnim', true);
			end
			sex = true
		end
		if value1 == "1" then
			playAnim('tf2DanceTitle', 'shot', true);
			if getProperty('dad.curCharacter') == 'heavyBlu' then
				playAnim('dad', 'shot', true);
				setProperty('dad.specialAnim', true);
			end
		end
		if value1 == "2" then
			sex = false
		end
	end
end