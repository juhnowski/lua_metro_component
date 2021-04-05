local orbita_camera_errors = {}
local orbita_camera = require "orbita_camera"
--[[
Слайд 1 Состояние оборудования Ощибки камеры:
--]]
function orbita_camera_errors.init()
	orbita_camera_errors.init_space()
	orbita_camera_errors.init_values()
end

function orbita_camera_errors.init_space()
	box.schema.space.create('camera_errors')
	box.space.camera_errors:create_index('primary')
end

function orbita_camera_errors.init_values()
	orbita_camera_errors.add(orbita_camera.ERROR_UNKNOWN, 'Неизвестная ошибка')
	orbita_camera_errors.add(orbita_camera.ERROR_CAM_1, 'Не работает Камера 1')
	orbita_camera_errors.add(orbita_camera.ERROR_CAM_2, 'Не работает Камера 2')
	orbita_camera_errors.add(orbita_camera.ERROR_CAM_3, 'Не работает Камера 3')
	orbita_camera_errors.add(orbita_camera.ERROR_CAM_4, 'Не работает Камера 4')
	orbita_camera_errors.add(orbita_camera.ERROR_CAM_5, 'Не работает Камера 5')
	orbita_camera_errors.add(orbita_camera.ERROR_CAM_6, 'Не работает Камера 6')
	orbita_camera_errors.add(orbita_camera.ERROR_CAM_7, 'Не работает Камера 7')
	orbita_camera_errors.add(orbita_camera.ERROR_CAM_8, 'Не работает Камера 8')
	orbita_camera_errors.add(orbita_camera.ERROR_CAM_9, 'Не работает Камера 9')
end

function orbita_camera_errors.add(err_code, err_message)
	box.space.camera_errors:insert{err_code, err_message}
end

function orbita_camera_errors.get(err_code)
	return box.space.camera_errors:select{err_code}
end

return orbita_camera_errors