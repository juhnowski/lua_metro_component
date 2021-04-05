local orbita_can = {}
--[[
- сопоставление интерфейса CAN одному из типов устройств, которые могут вешаться на CAN (ничего, IRMA);

Компонент:

CAN:
+------------+-+
|ничего      |v|
+------------+-+
|ничего      |
|IRMA        |
+------------+

--]]
orbita_can.NOTHING = 'ничего'
orbita_can.IRMA = 'IRMA'

function orbita_can.init()
	orbita_can.init_space()
	orbita_can.init_values()	
end

function orbita_can.init_space()
	orbita_can.init_can_list()
	box.schema.space.create('can')
	box.space.can:create_index('primary')
end

function orbita_can.init_values()
	box.space.can:insert{1, 1}
end



function orbita_can.init_can_list()
	box.schema.space.create('can_list')
	box.space.can_list:create_index('primary')
	box.space.can_list:insert{1, orbita_can.NOTHING}
	box.space.can_list:insert{2, orbita_can.IRMA}
end

function orbita_can.get_can_list()
	return box.space.can_list:select{}
end

function orbita_can.get_can()
	return box.space.can:select{1}
end

function orbita_can.get_can_name(id)
	return box.space.can_list:select{id}
end

function orbita_can.set_can(dev_id)
	box.space.can:update({1}, {{'=', 2, dev_id}})
end


return orbita_can