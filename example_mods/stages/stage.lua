function onCreate()
	-- background shit
	makeLuaSprite('stageback', 'stageback', -380, -125);
	setScrollFactor('stageback', 1, 1);
	scaleObject('stageback', 1.1, 1.1);

	if not lowQuality then
	    	makeLuaSprite('Sun', 'Sun', 90, -600);
	    	setScrollFactor('Sun', 1, 1);
	    	scaleObject('Sun', 4.5, 4.5);
	end

	addLuaSprite('stageback', false);
	addLuaSprite('Sun', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end