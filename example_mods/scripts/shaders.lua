local shaderName = "bloom"
local shaderName2 = "defaultstageshader"

function shaderCoordFix()
    runHaxeCode([[
        resetCamCache = function(?spr) {
            if (spr == null || spr.filters == null) return;
            spr.__cacheBitmap = null;
            spr.__cacheBitmapData = null;
        }
        
        fixShaderCoordFix = function(?_) {
            resetCamCache(game.camGame.flashSprite);
            resetCamCache(game.camHUD.flashSprite);
            resetCamCache(game.camOther.flashSprite);
        }
    
        FlxG.signals.gameResized.add(fixShaderCoordFix);
        fixShaderCoordFix();
        return;
    ]])
    
    local temp = onDestroy
    function onDestroy()
        runHaxeCode([[
            FlxG.signals.gameResized.remove(fixShaderCoordFix);
            return;
        ]])
        if (temp) then temp() end
    end
end

function onCreate()

	luaDebugMode = true

    makeLuaSprite("tempShader0")
    makeLuaSprite("tempShader1")
	
	shaderCoordFix()
	
	runHaxeCode([[
		shaderCat = [];
	]])
end

function onCreatePost()
    if shadersEnabled then
        addShader(shaderName, 'tempShader0')   
        addShader(shaderName2, 'tempShader1')
    end
end

--use in oncreatepost
function addShader(shader,tag,camera,isglobal)
    camera = camera or 'camGame'
    makeLuaSprite(tag)
    runHaxeCode([[
        var shaderName = "]] .. shader .. [[";
    
        game.initLuaShader(shaderName);
        var shader0 = game.createRuntimeShader(shaderName);
        shaderCat.push(new ShaderFilter(shader0));
        
        ]] .. (isglobal and '' or 'game.')  .. camera .. [[.setFilters(shaderCat);
        game.getLuaObject("]] .. tag .. [[").shader = shader0;
    ]]) --i spent hours trying to fix this and even after i still have no idea wtf happened lolol
    --debugPrint(shader..' catalogued')
end