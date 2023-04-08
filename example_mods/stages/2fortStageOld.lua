function onCreate()
	-- background shit
	makeLuaSprite('2fortStageOld', '2fortStageOld', -450, -150);
	setScrollFactor('2fortStageOld', 0.9, 0.9);
	scaleObject('2fortStageOld', 1.1, 1.1);

        makeAnimatedLuaSprite('tf2DanceTitleOld', 'tf2DanceTitleOld', 800, 100)
        luaSpriteAddAnimationByPrefix('tf2DanceTitleOld', 'tf2DanceTitleOld', 'tf2DanceTitle tfDance', 24, true);
	setScrollFactor('tf2DanceTitleOld', 0.7, 0.7);
        objectPlayAnimation('tf2DanceTitleOld', 'dance', false);
	scaleObject('tf2DanceTitleOld', 0.85, 0.85);

	makeLuaSprite('stagefront', 'stagefront', -650, 600);
	setScrollFactor('stagefront', 0.9, 0.9);
	scaleObject('stagefront', 1.1, 1.1);

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

	addLuaSprite('2fortStageOld', false);
	addLuaSprite('tf2DanceTitleOld', false);
	addLuaSprite('stagefront', false);
	addLuaSprite('stagelight_left', false);
	addLuaSprite('stagelight_right', false);
	addLuaSprite('stagecurtains', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end