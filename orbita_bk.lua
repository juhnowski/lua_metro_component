local orbita_bk = {}

--[[
Слайд 1 Состояние оборудования - БК
--]]
orbita_bk.OK = 0
orbita_bk.ERROR_UNKNOWN = 1
orbita_bk.ERROR_DISK_FULL = 2
orbita_bk.ERROR_OS = 3
orbita_bk.ERROR_DB = 4
orbita_bk.ERROR_CONNECTION = 5
orbita_bk.ERROR_ORBITA = 6

function orbita_bk.init()
	orbita_bk.init_space()
	orbita_bk.init_values()
end

function orbita_bk.init_space()
	box.schema.space.create('bk')
	box.space.bk:create_index('primary')
end

function orbita_bk.init_values()
	box.space.bk:insert{1, orbita_bk.OK}
end

function orbita_bk.set_err(err)
	box.space.bk:update({1}, {{'=', 2, err}})
end

function orbita_bk.set_ok()
	box.space.bk:update({1}, {{'=', 2, orbita_bk.OK}})
end

function orbita_bk.get()
	bk_table = box.space.bk:select{1}
	--orbita_table_util.print_r(askp_table)
	local current_state = -1
	for k,v in pairs(bk_table) do
		current_state = v[2]
	end

	if current_state == -1 then
		return orbita_bk.ERROR_UNKNOWN
	else
		return current_state
	end

end

return orbita_bk