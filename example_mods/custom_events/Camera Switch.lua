function onEvent(name, value1, value2)
    if name == 'Camera Switch' then
        doTweenAlpha('camHUDOff', value1, tonumber(value2), 0.001, 'linear')
    end
end