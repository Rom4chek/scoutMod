function onCreatePost() --script made by impostor, credit me now or i will do an unfunny
    makeLuaText("message", "FNF - Scout Funkin Fortress 2", 560, 30, 30)
    setTextAlignment("message", "right")
    addLuaText("message")

    makeLuaText("engineText", "Scout Engine (PE "..version..")", 560, 30, 30)
    setTextAlignment("engineText", "right")
    addLuaText("engineText")

    if getPropertyFromClass('ClientPrefs', 'downScroll') == false then
        setProperty('message.y', 670)
        setProperty('engineText.y', 690)
        setProperty('message.x', 705)
        setProperty('engineText.x', 705)
    end
end