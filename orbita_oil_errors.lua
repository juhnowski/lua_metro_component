local orbita_oil_errors = {}
local orbita_oil = require "orbita_oil"
--[[
Слайд 1 Состояние оборудования Ощибки Уровня масла:
--]]

function orbita_oil_errors.init()
	box.schema.space.create('oil_errors')
	box.space.oil_errors:create_index('primary')
	orbita_oil_errors.add(orbita_oil.ERROR_UNKNOWN, 'Неизвестная ошибка Уровня масла')
	orbita_oil_errors.add(orbita_oil.LOW_LEVEL, 'Низкий уровень масла')
	orbita_oil_errors.add(orbita_oil.SERVICE_SOON, 'Необходимо сервисное обслуживание')
end

function orbita_oil_errors.add(err_code, err_message)
	box.space.oil_errors:insert{err_code, err_message}
end

function orbita_oil_errors.get(err_code)
	box.space.oil_errors:select{err_code}
end

return orbita_oil_errors