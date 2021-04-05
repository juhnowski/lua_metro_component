local orbita_oil = {}

--[[
Слайд 1 Состояние оборудования - Уровень масла
--]]
orbita_oil.OK = 0
orbita_oil.ERROR_UNKNOWN = 1
orbita_oil.LOW_LEVEL = 2
orbita_oil.SERVICE_SOON = 3

function orbita_oil.init()
	box.schema.space.create('oil')
	box.space.oil:create_index('primary')
end

function orbita_oil.set_err(tm, err)
	box.space.oil:insert{tm, err}
end

function orbita_oil.set_ok(tm)
	box.space.oil:insert{tm, orbita_oil.OK}
end

return orbita_oil