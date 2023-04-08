-- Event notes hooks
function onEvent(name, value1, value2)
	if name == 'Set_Health' then
		amount = tonumber(value1);
		if amount < getProperty('health') then
	    	setProperty('health', amount);
    	end
	end
end