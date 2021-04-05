local orbita_askp_errors = {}
local orbita_askp = require "orbita_askp"
--[[
Слайд 1 Состояние оборудования Ощибки АСКП:
--]]

function orbita_askp_errors.init()
	orbita_askp_errors.init_space()
	orbita_askp_errors.init_values()	
end

function orbita_askp_errors.init_values()
	orbita_askp_errors.add(orbita_askp.ERROR_UNKNOWN, 'Неизвестная ошибка')
	orbita_askp_errors.add(orbita_askp.ERROR_ASKP_1, 'АСКП Дверь 1 не работает')
	orbita_askp_errors.add(orbita_askp.ERROR_ASKP_2, 'АСКП Дверь 2 не работает')
	orbita_askp_errors.add(orbita_askp.ERROR_ASKP_3, 'АСКП Дверь 3 не работает')
end

function orbita_askp_errors.init_space()
	box.schema.space.create('askp_errors')
	box.space.askp_errors:create_index('primary')
end

function orbita_askp_errors.add(err_code, err_message)
	box.space.askp_errors:insert{err_code, err_message}
end

function orbita_askp_errors.get(err_code)
	return box.space.askp_errors:select{err_code}
end

return orbita_askp_errors