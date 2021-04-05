local orbita_askp = {}
--local orbita_table_util = require('orbita_table_util')

--[[
Слайд 1 Состояние оборудования - АСКП
--]]
orbita_askp.OK = 0
orbita_askp.ERROR_UNKNOWN = 1
orbita_askp.ERROR_ASKP_1= 2
orbita_askp.ERROR_ASKP_2= 3
orbita_askp.ERROR_ASKP_3= 4

function orbita_askp.init()
	orbita_askp.init_space()
	orbita_askp.init_values()	
end

function orbita_askp.init_space()
	box.schema.space.create('askp')
	box.space.askp:create_index('primary')
end

function orbita_askp.init_values()
	box.space.askp:insert{1, orbita_askp.ERROR_UNKNOWN}
	box.space.askp:insert{2, orbita_askp.ERROR_UNKNOWN}
	box.space.askp:insert{3, orbita_askp.ERROR_UNKNOWN}
end


function orbita_askp.set_err(door, err)
	box.space.askp:update({door}, {{'=', 2, err}})
end

function orbita_askp.set_ok(door)
	box.space.askp:update({door}, {{'=', 2, orbita_askp.OK}})
end

function orbita_askp.get(door)
	askp_table = box.space.askp:select{door}
	--orbita_table_util.print_r(askp_table)
	local current_state = -1
	for k,v in pairs(askp_table) do
		current_state = v[2]
	end

	if current_state == -1 then
		return orbita_askp.ERROR_UNKNOWN
	else
		return current_state
	end

end


return orbita_askp