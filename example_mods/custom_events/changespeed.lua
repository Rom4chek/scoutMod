function onEvent(name, value1, value2)
   if name == 'changespeed' then
        setProperty('songSpeed', getProperty('songSpeed') + value1);
    end
end
