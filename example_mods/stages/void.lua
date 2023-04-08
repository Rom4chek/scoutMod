function onCreate()
	-- background shit
	initLuaShader('GlitchShader');
	makeLuaSprite('void', 'GodStage', -800, -400);
	setScrollFactor('void', 0.1, 0.1);
	scaleObject('void', 1.7, 1.7);

	addLuaSprite('void', false);
	setSpriteShader('void', 'GlitchShader');
	
	--close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end

elapsedTime = 0;
function onUpdate(elapsed)
    elapsedTime = elapsedTime + elapsed
    setShaderFloat('void', 'uTime', elapsedTime);
    setProperty('void.alpha', math.sin(elapsedTime) / 2.5 + 0.4); --this is just to make the stage darker and brighter you can delete it
end
nightTime = '878787' --You can delete this script there and everything below it
function onCreatePost()
    setProperty('dad.color', getColorFromHex(nightTime));
    setProperty('boyfriend.color', getColorFromHex(nightTime));
end



function onEvent(eventName, value1, value2)

end