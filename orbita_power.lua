local orbita_power = {}

--[[
Слайд 1 Состояние оборудования - Энергоснабжение
--]]
orbita_power.OK = 0
orbita_power.ERROR_UNKNOWN = 1
orbita_power.ERROR_FUSE_1 = 2
orbita_power.ERROR_FUSE_2 = 3
orbita_power.ERROR_FUSE_3 = 4

function orbita_power.init()
	box.schema.space.create('power')
	box.space.power:create_index('primary')
end

function orbita_power.set_err(tm, err)
	box.space.power:insert{tm, err}
end

function orbita_power.set_ok(tm)
	box.space.power:insert{tm, orbita_power.OK}
end

return orbita_power