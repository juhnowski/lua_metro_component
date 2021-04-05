local orbita_hdd = {}
--[[
просмотр дисков и выбор диска для форматирования и для записи;

Компонент:

Диски:

    +--------+-+
    |/dev/sda|v|
    +--------+-+
    |/dev/sda|
    |/dev/sdb|
    |/dev/sdc|
    +--------+
--]]

function orbita_hdd.get_list()
    local result = os.capture("df -h")
    return result
end

function orbita_hdd.init()
    box.schema.space.create('hdd')
    box.space.hdd:create_index('primary')
    box.space.hdd:insert{1,'/dev/sda'}
end

function orbita_hdd.get()
    return box.space.hdd:select{1}
end

function orbita_hdd.set(hdd)
    box.space.hdd:update({1}, {{'=', 2, hdd}})
end

return orbita_hdd