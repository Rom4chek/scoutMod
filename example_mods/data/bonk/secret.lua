--[[
    By ToufG#6291, please credit.
]]--

-------------------(change the word here)-------------------
local word = {
    'C',
    'H',
    'I',
    'N',
    'G',
    'C',
    'H',
    'E',
    'N',
    'G'
}
------------------------------------------------------------
local selected = 1
function onUpdate(elapsed)
    if keyboardJustPressed(word[selected]) then
        if selected < #word then
            selected = selected + 1
        else
            secretWordTyped()
            selected = 1
        end
    end
end
function secretWordTyped()
     loadSong('ching-cheng-hanji', 0)
end
