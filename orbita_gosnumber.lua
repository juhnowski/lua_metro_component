local orbita_gosnumber = {}
--[[
настройка госномера

Компонент:

Номер государственной регистрации:
 +------+ +---+
 |А123БВ| |177|
 +------+ +---+

--]]

function orbita_gosnumber.init()
        box.schema.space.create('gosnumber')
        box.space.gosnumber:create_index('primary')
        box.space.gosnumber:insert{1, 'А123БВ', 177}
end

function orbita_gosnumber.get_gosnumber()
    return box.space.gosnumber:select{1}
end

function orbita_gosnumber.set_gosnumber(num, code)
    box.space.gosnumber:update({1}, {{'=', 2, num}})
    box.space.gosnumber:update({1}, {{'=', 3, code}})
end

return orbita_gosnumber