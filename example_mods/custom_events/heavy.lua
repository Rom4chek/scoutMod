local goShot = false

function onCreate()
luaDebugMode = true
end

-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'heavy' then
		if value1 == "1" then
	    	goShot = true
			debugPrint("sex")
		end
		if value1 == "2" then
	    	goShot = false
		end
	end
end

function onUpdate(elapsed)
	if goShot then
		if (getProperty('health') > 0.1) then
        	setProperty('health', getProperty('health') - 0.0025)
       end
    end
end