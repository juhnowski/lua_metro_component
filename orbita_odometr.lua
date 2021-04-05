local orbita_odometr = {}

--[[
Слайд 1 Одометр км
]]

function orbita_odometr.init()
	box.schema.space.create('odometr')
	box.space.odometr:create_index('primary')
end

function orbita_odometr.add(tm, m)
	box.space.odometr:insert{tm, m}
end

return orbita_odometr