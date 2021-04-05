local orbita_power_errors = {}
local orbita_power = require "orbita_power"
--[[
Слайд 1 Состояние оборудования Ощибки Системы энергоснабжения:
--]]

function orbita_power_errors.init()
	box.schema.space.create('power_errors')
	box.space.power_errors:create_index('primary')
	orbita_power_errors.add(orbita_power.ERROR_UNKNOWN, 'Неизвестная ошибка Системы Энергоснабжения')
	orbita_power_errors.add(orbita_power.ERROR_FUSE_1, 'Предохранитель №1')
	orbita_power_errors.add(orbita_power.ERROR_FUSE_2, 'Предохранитель №2')
	orbita_power_errors.add(orbita_power.ERROR_FUSE_3, 'Предохранитель №3')	
end

function orbita_power_errors.add(err_code, err_message)
	box.space.power_errors:insert{err_code, err_message}
end

function orbita_power_errors.get(err_code)
	box.space.power_errors:select{err_code}
end

return orbita_power_errors