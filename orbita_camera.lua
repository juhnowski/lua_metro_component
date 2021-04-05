local orbita_camera = {}

--[[
Слайд 1 Состояние оборудования - Камера
--]]
orbita_camera.OK = 0
orbita_camera.ERROR_UNKNOWN = 1
orbita_camera.ERROR_CAM_1= 2
orbita_camera.ERROR_CAM_2= 3
orbita_camera.ERROR_CAM_3= 4
orbita_camera.ERROR_CAM_4= 5
orbita_camera.ERROR_CAM_5= 6
orbita_camera.ERROR_CAM_6= 7
orbita_camera.ERROR_CAM_7= 8
orbita_camera.ERROR_CAM_8= 9
orbita_camera.ERROR_CAM_9= 10

function orbita_camera.init()
	orbita_camera.init_space()
	orbita_camera.init_values()
end

function orbita_camera.init_space()
	box.schema.space.create('camera')
	box.space.camera:create_index('primary')
end

function orbita_camera.init_values()
	box.space.camera:insert{1, orbita_camera.OK}
end

function orbita_camera.set_err(err)
	box.space.camera:update({1}, {{'=', 2, err}})
end

function orbita_camera.set_ok()
	box.space.camera:update({1}, {{'=', 2, orbita_camera.OK}})
end

function orbita_camera.get()
	camera_table = box.space.camera:select{1}
	--orbita_table_util.print_r(askp_table)
	local current_state = -1
	for k,v in pairs(camera_table) do
		current_state = v[2]
	end

	if current_state == -1 then
		return orbita_camera.ERROR_UNKNOWN
	else
		return current_state
	end

end

return orbita_camera