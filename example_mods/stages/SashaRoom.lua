function onCreate()
	-- background shit
	makeLuaSprite('SashaRoom', 'SashaRoom', -450, -325);
	setScrollFactor('SashaRoom', 0.9, 0.9);
	scaleObject('SashaRoom', 1.2, 1.2);

       	addLuaSprite('SashaRoom', false);

	--close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
