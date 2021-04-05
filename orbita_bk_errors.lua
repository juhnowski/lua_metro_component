local orbita_bk_errors = {}
local orbita_bk = require "orbita_bk"
--[[
Слайд 1 Состояние оборудования Ощибки Бортового Компьютера:
--]]

function orbita_bk_errors.init()
	orbita_bk_errors.init_space()
	orbita_bk_errors.init_values()
end

function orbita_bk_errors.init_space()
	box.schema.space.create('bk_errors')
	box.space.bk_errors:create_index('primary')
end

function orbita_bk_errors.init_values()
	orbita_bk_errors.add(orbita_bk.ERROR_UNKNOWN, 'Неизвестная ошибка БК')
	orbita_bk_errors.add(orbita_bk.ERROR_DISK_FULL, 'Место на диске закончилось')
	orbita_bk_errors.add(orbita_bk.ERROR_OS, 'Ошибка ОС')
	orbita_bk_errors.add(orbita_bk.ERROR_DB, 'Ошибка БД')
	orbita_bk_errors.add(orbita_bk.ERROR_CONNECTION, 'Ошибка соединения')
	orbita_bk_errors.add(orbita_bk.ERROR_ORBITA, 'Ошибка ПО')
end

function orbita_bk_errors.add(err_code, err_message)
	box.space.bk_errors:insert{err_code, err_message}
end

function orbita_bk_errors.get(err_code)
	return box.space.bk_errors:select{err_code}
end

return orbita_bk_errors