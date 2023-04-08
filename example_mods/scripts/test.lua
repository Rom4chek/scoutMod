keyList = {'T', 'E', 'S', 'T'}
curKey = 0

function onUpdate()
   if keyboardJustPressed(keyList[1]) then
      curKey = curKey + 1
      table.remove(keyList, 1)
   end
   if curKey == 4 then -- replace 4 with the amount of letters in your code
      -- do something
   end
end