

function onCreate()
    makeLuaText('healthText', 'HP: ' .. math.floor(getProperty("health") * 50), 300, screenWidth / 2 - 300 / 2, screenHeight / 3.2 - 270 / 1.5)
    addLuaText('healthText')
    setTextSize('healthText', 24);
end
function onUpdate(elapsed)
	-- start of "update", some variables weren't updated yet
    setTextString('healthText', 'HP: ' .. math.floor(getProperty("health") * 50))
end

