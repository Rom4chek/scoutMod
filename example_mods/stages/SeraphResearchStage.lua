function onCreate()
	-- background shit
	makeLuaSprite('SeraphResearch', 'SeraphResearch', -450, -150);
	setScrollFactor('SeraphResearch', 0.9, 0.9);
	scaleObject('SeraphResearch', 1.1, 1.1);

        makeAnimatedLuaSprite('vhs', 'vhs', -151, -50)
        luaSpriteAddAnimationByPrefix('vhs', 'vhs', 'vhs idle', 24, true);
	setScrollFactor('vhs', 0.7, 0.7);
        objectPlayAnimation('vhs', 'idle', false);
	scaleObject('vhs', 3.4, 3.4);

	-- sprites that only load if Low Quality is turned off
	if not lowQuality then
		makeLuaSprite('stagelight_left', 'stage_light', -125, -100);
		setScrollFactor('stagelight_left', 0.9, 0.9);
		scaleObject('stagelight_left', 1.1, 1.1);
		
		makeLuaSprite('stagelight_right', 'stage_light', 1225, -100);
		setScrollFactor('stagelight_right', 0.9, 0.9);
		scaleObject('stagelight_right', 1.1, 1.1);
		setProperty('stagelight_right.flipX', true); --mirror sprite horizontally

		makeLuaSprite('stagecurtains', 'stagecurtains', -500, -300);
		setScrollFactor('stagecurtains', 1.3, 1.3);
		scaleObject('stagecurtains', 0.9, 0.9);
	end

	addLuaSprite('SeraphResearch', false);
	addLuaSprite('vhs', true);
	addLuaSprite('stagefront', false);
	addLuaSprite('stagelight_left', false);
	addLuaSprite('stagelight_right', false);
	addLuaSprite('stagecurtains', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end