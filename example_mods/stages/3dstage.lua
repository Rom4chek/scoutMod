local elapsedtime = 0
local shaderName = 'FuriosityShader'

function onCreate()
    luaDebugMode = true
    makeLuaSprite('back', 'angryurghh', -300, -320)
    setScrollFactor('back', 1, 1);
    scaleObject('back', 1.3, 1.3);
    addLuaSprite('back', false)

    initLuaShader(shaderName)
    setSpriteShader("back", shaderName)
    setShaderFloat("back", 'uSpeed', 1)
    setShaderFloat("back", 'uFrequency', 2)
    setShaderFloat("back", 'uWaveAmplitude', 1)
end

function onUpdatePost(elapsed)
    elapsedtime = elapsedtime + elapsed
    setShaderFloat("back", 'uTime', elapsedtime)
end

-- local elapsedtime = 0
-- local swayAmplitude = 300
-- local spinAmplitude = 20

-- function onUpdate(elapsed)
--     elapsedtime = elapsedtime + elapsed
--     setGraphicSize('back', (math.sin(elapsedtime) * swayAmplitude) + 3096, (math.cos(elapsedtime) * swayAmplitude) + 2248)
--     updateHitbox('back')
--     doTweenAngle('angletween', 'back', math.sin(elapsedtime) * spinAmplitude, 1, 'linear')
--     --doTweenX('xtween', 'back', (math.sin(elapsedtime) * 350) - 650, 1, 'linear')
--     -- doTweenY('ytween', 'back', math.cos(elapsedtime) * 300, 0.5, 'linear')
-- end