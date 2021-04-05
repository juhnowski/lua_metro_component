local orbita_voice = {}

--[[
Слайд 1 Состояние оборудования - Голос
--]]
orbita_voice.OK = 0
orbita_voice.ERROR_UNKNOWN = 1
orbita_voice.ERROR_MICROPHONE_DISCONNECTED = 2
orbita_voice.ERROR_VOICE_STOP_DECLARATION = 3

function orbita_voice.init()
	box.schema.space.create('voice')
	box.space.voice:create_index('primary')
end

function orbita_voice.set_err(tm, err)
	box.space.voice:insert{tm, err}
end

function orbita_voice.set_ok(tm)
	box.space.voice:insert{tm, orbita_voice.OK}
end

return orbita_voice