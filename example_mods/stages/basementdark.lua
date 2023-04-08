function onCreate()
	-- background shit

	makeLuaSprite('basementdark', 'basementdark', -600, -580);
	setLuaSpriteScrollFactor('basementdark', 1.1, 1.1);
	scaleObject('basementdark', 1.1, 1.1);
                addLuaSprite('basementdark',false)

    makeAnimatedLuaSprite('CUpheqdshidA','CUpheqdshidA',-400,-200)
    scaleObject('CUpheqdshidA', 2, 2);
    addAnimationByPrefix('CUpheqdshidA','CUpheqdshid','CUpheqdshid',24,true)
  addLuaSprite('CUpheqdshidA',true)

end