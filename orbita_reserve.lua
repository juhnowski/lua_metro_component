local orbita_reserve = {}

--[[
Слайд 1 Запас хода км
]]

function orbita_reserve.init()
	box.schema.space.create('reserve')
	box.space.reserve:create_index('primary')
end

function orbita_reserve.add(tm, m)
	box.space.reserve:insert{tm, m}
end

return orbita_reserve