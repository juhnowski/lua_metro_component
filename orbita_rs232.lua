local orbita_rs232 = {}
--[[
- сопоставление интерфейса RS232-1 одному из типов устройств, которые могут вешаться на RS232 (ничего, прием ГНСС , выдача ГНСС)

Компонент:

RS232_1:
+------------+-+
|ничего      |v|
+------------+-+
|ничего      |
|прием ГНСС  |
|выдача ГНСС |
+------------+

RS232_2:
+------------+-+
|ничего      |v|
+------------+-+
|ничего      |
|прием ГНСС  |
|выдача ГНСС |
+------------+

--]]

function orbita_rs232.init()
orbita_rs232.init_tdev_list()
box.schema.space.create('tdev')
box.space.tdev:create_index('primary')
box.space.tdev:insert{1, 1}
box.space.tdev:insert{2, 1}
end

function orbita_rs232.init_tdev_list()
box.schema.space.create('tdev_list')
box.space.tdev_list:create_index('primary')
box.space.tdev_list:insert{1, 'ничего'}
box.space.tdev_list:insert{2, 'прием ГНСС'}
box.space.tdev_list:insert{3, 'выдача ГНСС'}
end

function orbita_rs232.get_tdev_list()
return box.space.tdev_list:select{}
end

function orbita_rs232.get_tdev(id)
return box.space.tdev:select{id}
end

function orbita_rs232.get_tdev_name(id)
return box.space.tdev_list:select{id}
end

function orbita_rs232.set_tdev(rs_id, dev_id)
box.space.tdev:update({rs_id}, {{'=', 2, dev_id}})
end


return orbita_rs232