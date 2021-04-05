local orbita_rs485 = {}
--[[
(ручное) сопоставление интерфейса RS485-1 и RS485-2 одному из типов устройств, которые могут вешаться на RS485 (список будет зашит в файл конфигурации - ничего, "Табло ОРБИТА", "Табло Искра", "ДУТ Омником")

Компонент:

RS485_1:
    +------------+-+
    |ничего      |v|
    +------------+-+
    |ничего      |
    |Табло ОРБИТА|
    |Табло Искра |
    |ДУТ Омником |
    +------------+

RS485_2:
    +------------+-+
    |ничего      |v|
    +------------+-+
    |ничего      |
    |Табло ОРБИТА|
    |Табло Искра |
    |ДУТ Омником |
    +------------+

--]]

function orbita_rs485.init()
    orbita_rs485.init_dev_list()
    box.schema.space.create('dev')
    box.space.dev:create_index('primary')
    box.space.dev:insert{1, 1}
    box.space.dev:insert{2, 1}
end

function orbita_rs485.init_dev_list()
    box.schema.space.create('dev_list')
    box.space.dev_list:create_index('primary')
    box.space.dev_list:insert{1, 'ничего'}
    box.space.dev_list:insert{2, 'Табло ОРБИТА'}
    box.space.dev_list:insert{3, 'Табло Искра'}
    box.space.dev_list:insert{4, 'ДУТ Омником'}
end

function orbita_rs485.get_dev_list()
    return box.space.dev_list:select{}
end

function orbita_rs485.get_dev(id)
    return box.space.dev:select{id}
end

function orbita_rs485.get_dev_name(id)
    return box.space.dev_list:select{id}
end

function orbita_rs485.set_dev(rs_id, dev_id)
    box.space.dev:update({rs_id}, {{'=', 2, dev_id}})
end


return orbita_rs485