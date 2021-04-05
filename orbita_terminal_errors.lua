local orbita_terminal_errors = {}
local orbita_terminal = require "orbita_terminal"
--[[
   Ощибки терминала:
--]]

orbita_terminal.INIT = -1
orbita_terminal.OK = 0
orbita_terminal.ERROR_UNKNOWN = 1
orbita_terminal.ERROR_SERIAL = 2
orbita_terminal.ERROR_DEVICE_NOT_FOUND = 3
orbita_terminal.ERROR_READ_RFID = 4
orbita_terminal.ERROR_READ_COORD = 5
orbita_terminal.ERROR_READ_DUT = 6

function orbita_terminal_errors.init()
	box.schema.space.create('terminal_errors')
	box.space.terminal_errors:create_index('primary')
	orbita_terminal_errors.add(orbita_terminal.INIT, 'Инициализация связи с терминалом')
	orbita_terminal_errors.add(orbita_terminal.OK, 'Ok')
	orbita_terminal_errors.add(orbita_terminal.ERROR_UNKNOWN, 'Неизвестная ошибка')
	orbita_terminal_errors.add(orbita_terminal.ERROR_SERIAL, 'Ошибка чтения из серийного порта')
	orbita_terminal_errors.add(orbita_terminal.ERROR_DEVICE_NOT_FOUND, 'Терминал не подключен')
	orbita_terminal_errors.add(orbita_terminal.ERROR_READ_RFID, 'Ошибка чтения RFID')
	orbita_terminal_errors.add(orbita_terminal.ERROR_READ_COORD, 'Ошибка чтения COORD')
	orbita_terminal_errors.add(orbita_terminal.ERROR_READ_DUT, 'Ошибка чтения DUT')
end

function orbita_terminal_errors.add(err_code, err_message)
	box.space.terminal_errors:insert{err_code, err_message}
end

function orbita_terminal_errors.get(err_code)
	box.space.terminal_errors:select{err_code}
end

return orbita_terminal_errors