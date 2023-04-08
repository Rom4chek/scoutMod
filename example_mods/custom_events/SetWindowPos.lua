function onEvent(name, value1, value2)
	if name == 'SetWindowPos' then
		setPropertyFromClass('openfl.Lib', 'application.window.y', tonumber(value2))
   		setPropertyFromClass('openfl.Lib', 'application.window.x', tonumber(value1))
	end
end
		