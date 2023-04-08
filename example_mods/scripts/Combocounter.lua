function onSongStart()
    makeLuaText('hits', 'Total Combo:' .. getProperty('songHits'), 200, 0, 350); 
    makeLuaText('sicks', 'Sick!:' .. getProperty('sicks'), 200, 0, 375);
    makeLuaText('goods', 'Good:' .. getProperty('goods'), 200, 0, 400);
    makeLuaText('bads', 'Bad:' .. getProperty('bads'), 200, 0, 425);
    makeLuaText('shits', 'Shit:' .. getProperty('shits'), 200, 0, 450);
     makeLuaText('misses', 'Misses:' .. getProperty('songMisses'), 200, 0, 475);
    addLuaText('hits');
    addLuaText('sicks');
    addLuaText('goods');
    addLuaText('bads');
    addLuaText('shits');
    addLuaText('misses');
end

function onRecalculateRating()
    setTextString('hits', 'Total Combo:' .. getProperty('songHits'));
    setTextString('sicks', 'Sick!:' .. getProperty('sicks'));
    setTextString('goods', 'Good:' .. getProperty('goods'));
    setTextString('bads', 'Bad:' .. getProperty('bads'));
    setTextString('shits', 'Shit:' .. getProperty('shits'));
    setTextString('misses', 'Misses:' .. getProperty('songMisses'));
end