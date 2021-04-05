local orbita_msg = {}

--[[
Слайд 1 Входящие сообщения
--]]

function orbita_msg.init()
	box.schema.space.create('msg')
	box.space.msg:create_index('primary')
end

function orbita_msg.add(tm, m)
	box.space.msg:insert{tm, m}
end

return orbita_msg