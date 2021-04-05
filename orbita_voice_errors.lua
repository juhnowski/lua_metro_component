local orbita_voice_errors = {}
local orbita_voice = require "orbita_voice"
--[[
Слайд 1 Состояние оборудования Ощибки звука:
--]]

function orbita_voice_errors.init()
	box.schema.space.create('voice_errors')
	box.space.voice_errors:create_index('primary')
	orbita_voice_errors.add(orbita_voice.ERROR_UNKNOWN, 'Неизвестная ошибка')
	orbita_voice_errors.add(orbita_voice.ERROR_MICROPHONE_DISCONNECTED, 'Микрофон не подключен')
	orbita_voice_errors.add(orbita_voice.ERROR_VOICE_STOP_DECLARATION, 'Остановки не объявляются')
end

function orbita_voice_errors.add(err_code, err_message)
	box.space.voice_errors:insert{err_code, err_message}
end

function orbita_voice_errors.get(err_code)
	box.space.voice_errors:select{err_code}
end

return orbita_voice_errors