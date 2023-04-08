--[[
    By ToufG#6291, please credit.
]]--

-------------------(change the word here)-------------------
local word = {
    'S',
    'W',
    'A',
    'M',
    'P',
    'I',
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
     loadSong('very-powerful', 0)
end
