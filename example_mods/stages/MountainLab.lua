function onCreate()
	-- background shit
	makeLuaSprite('MountainLab3', 'MountainLab3', -350, -150);
	setScrollFactor('MountainLab3', 0.9, 0.9);
	scaleObject('MountainLab3', 1.1, 1.1);

	makeLuaSprite('MountainLab2', 'MountainLab2', -350, -150);
	setScrollFactor('MountainLab2', 0.9, 0.9);
	scaleObject('MountainLab2', 1.1, 1.1);

	makeLuaSprite('MountainLab1', 'MountainLab1', -350, -150);
	setScrollFactor('MountainLab1', 0.9, 0.9);
	scaleObject('MountainLab1', 1.1, 1.1);

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

	addLuaSprite('MountainLab3', false);
	addLuaSprite('MountainLab2', false);
	addLuaSprite('MountainLab1', false);
	addLuaSprite('stagefront', false);
	addLuaSprite('stagelight_left', false);
	addLuaSprite('stagelight_right', false);
	addLuaSprite('stagecurtains', false);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end