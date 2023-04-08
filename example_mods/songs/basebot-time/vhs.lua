local shaderName = "vhs"

function onCreate()
	luaDebugMode = true
    initLuaShader(shaderName)

    makeLuaSprite("shaderSprite1")
    makeGraphic("shaderSprite1", screenWidth, screenHeight)

    setSpriteShader("shaderSprite1", shaderName)


	addHaxeLibrary("ShaderFilter", "openfl.filters")
    runHaxeCode([[
        var shaderArray = [
            new ShaderFilter(game.getLuaObject("shaderSprite1").shader)
        ];
        game.camGame.setFilters(shaderArray);
    ]])
end