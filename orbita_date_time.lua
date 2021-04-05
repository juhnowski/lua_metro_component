local orbita_date_time = {}

--[[
настройка даты и времени

Компонент:

Дата:
+--+ +--+ +----+
|01| |09| |2017|
+--+ +--+ +----+

Время:
+--+ +--+
|14| |15|
+--+ +--+
                                  +-+
Включите, чтобы внести изменения: |x|
                                  +-+
                                
 +-+
 |x| ГНСС
 +-+

 +-+
 |x| Видеосервер
 +-+

 +-+
 |x| Синхронизация времени
 +-+

                                          +-+
Активировать переход летнее/зимнее время: |x|
                                          +-+

Прибавить: +----------+-+
           |          |v|
           +----------+-+
           |          |
           | один час |
           | два часа |
           +----------+

Режим:     +----------+-+
           |          |v|
           +----------+-+
           |          |
           | неделя   |
           | дата     |
           +----------+

--------------------------------------------------------------
C:  1            2               3         4           5
           +----------+-+    +------+-+  +----+-+ +----------+
           |          |v|    |      |v|  |    |v| | 00:00:00 |
           +----------+-+    +------+-+  +----+-+ +----------+
           | январь   |      |  1й  |    | Пн |   
           | февраль  |      |  2й  |    | Вт |   
           | март     |      |  3й  |    | Ср |   
           | апрель   |      |  4й  |    | Чт | 
           | май      |      |Послед|    | Пт |
           | июнь     |      +-------    | Сб |
           | июль     |                  | Вс |
           | август   |                  +----+
           | сентябрь |
           | октябрь  |
           | ноябрь   |
           | декабрь  |
           +----------+
По:             6                 7         8           9
           +----------+-+    +------+-+  +----+-+ +----------+
           |          |v|    |      |v|  |    |v| | 00:00:00 |
           +----------+-+    +------+-+  +----+-+ +----------+
           | январь   |      |  1й  |    | Вс |   
           | февраль  |      |  2й  |    | Пн |   
           | март     |      |  3й  |    | Вт |   
           | апрель   |      |  4й  |    | Ср | 
           | май      |      |Послед|    | Чт |
           | июнь     |      +-------    | Пт |
           | июль     |                  | Сб |
           | август   |                  +----+
           | сентябрь |
           | октябрь  |
           | ноябрь   |
           | декабрь  |
           +----------+
--------------------------------------------------------------
Формат Даты:
           +-------------+-+
           |             |v|
           +-------------+-+
           | МЕС/ДЕН/ГОД |
           | ГОД/МЕС/ДЕН |
           | ДЕН/МЕС/ГОД |
           +-------------+

Формат Времени:
           +----------+-+
           |          |v|
           +----------+-+
           | 24 часа  |
           | 12 часов |
           +----------+

Часовой пояс
           +-------------------------------------------+-+
           |                                           |v|
           +-------------------------------------------+-+
           | UTC+2 — Калининградское время             |
           | UTC+3 — Московское время                  |
           | UTC+4 — Самарское время                   |
           | UTC+5 — Екатеринбургское время            |
           | UTC+6 — Омское время                      |
           | UTC+7 — Новосибирское время               |
           | UTC+8 — Иркутское время                   |
           | UTC+9 — Якутское время                    |
           | UTC+10 — Владивостокское время            |
           | UTC+11 — Среднеколымское время            |
           | UTC+12 — Камчатское время                 |
           | UTC+13 — Самоа, Тонга                     |
           | UTC+14 — Острова Лайн                     |
           | UTC−12 — Линия перемены даты              |
           | UTC−11 — Американское Самоа               |
           | UTC−10 — Гавайи                           |
           | UTC−9 — Аляска                            |
           | UTC−8 — Североамериканское тихоокеанское  |
           | UTC−7 — Горное время (США и Канада)       |
           | UTC−6 — Центральное время (США и Канада)  |
           | UTC−5 — Североамериканское восточное время|
           | UTC−4 — Атлантическое время (Канада)      |
           | UTC−3 — Южноамериканское восточное время  |
           | UTC−2 — Среднеатлантическое время         |
           | UTC+0 — Западноевропейское время          |
           | UTC+1 — Центральноевропейское время       |
           +-------------------------------------------+

--]]

function orbita_date_time.init_space()
    box.schema.space.create('date_time_add')
    box.space.date_time_add:create_index('primary')
    
    box.schema.space.create('date_time_add_list')
    box.space.date_time_add_list:create_index('primary')

    box.schema.space.create('date_time_mode')
    box.space.date_time_mode:create_index('primary')

    box.schema.space.create('date_time_mode_list')
    box.space.date_time_mode_list:create_index('primary')

    box.schema.space.create('date_time_winter')
    box.space.date_time_winter:create_index('primary')

    box.schema.space.create('date_time_month_list')
    box.space.date_time_month_list:create_index('primary')

    box.schema.space.create('date_time_week_list')
    box.space.date_time_week_list:create_index('primary')

    box.schema.space.create('date_time_dweek_list')
    box.space.date_time_dweek_list:create_index('primary')

    box.schema.space.create('date_time_gnss')
    box.space.date_time_gnss:create_index('primary')

    box.schema.space.create('date_time_videoserver')
    box.space.date_time_videoserver:create_index('primary')

    box.schema.space.create('date_time_sync')
    box.space.date_time_sync:create_index('primary')

    box.schema.space.create('date_time_activ')
    box.space.date_time_activ:create_index('primary')

    box.schema.space.create('date_time_format_date')
    box.space.date_time_format_date:create_index('primary')

    box.schema.space.create('date_time_format_date_list')
    box.space.date_time_format_date_list:create_index('primary')

    box.schema.space.create('date_time_format_time')
    box.space.date_time_format_time:create_index('primary')

    box.schema.space.create('date_time_format_time_list')
    box.space.date_time_format_time_list:create_index('primary')

    box.schema.space.create('date_time_zone')
    box.space.date_time_zone:create_index('primary')

    box.schema.space.create('date_time_zone_list')
    box.space.date_time_zone_list:create_index('primary')

end

function orbita_date_time.init_values()
    box.space.date_time_add_list:insert{1, "        "}
    box.space.date_time_add_list:insert{2, "один час"}
    box.space.date_time_add_list:insert{3, "два часа"}
    box.space.date_time_add:insert{1, 1}

    box.space.date_time_mode_list:insert{1, "      "}
    box.space.date_time_mode_list:insert{2, "неделя"}
    box.space.date_time_mode_list:insert{3, "дата"}
    box.space.date_time_mode:insert{1, 1}

    box.space.date_time_winter:insert{1, 10, 1, 1, "00:00:00", 4, 5, 1, "00:00:00"}
    box.space.date_time_month_list:insert{1, "январь"}
    box.space.date_time_month_list:insert{2, "февраль"}
    box.space.date_time_month_list:insert{3, "март"}
    box.space.date_time_month_list:insert{4, "апрель"}
    box.space.date_time_month_list:insert{5, "май"}
    box.space.date_time_month_list:insert{6, "июнь"}
    box.space.date_time_month_list:insert{7, "июль"}
    box.space.date_time_month_list:insert{8, "август"}
    box.space.date_time_month_list:insert{9, "сентябрь"}
    box.space.date_time_month_list:insert{10, "октябрь"}
    box.space.date_time_month_list:insert{11, "ноябрь"}
    box.space.date_time_month_list:insert{12, "декабрь"}

    box.space.date_time_week_list:insert{1, "1й"}
    box.space.date_time_week_list:insert{2, "2й"}
    box.space.date_time_week_list:insert{3, "3й"}
    box.space.date_time_week_list:insert{4, "4й"}
    box.space.date_time_week_list:insert{5, "Послед"}

    box.space.date_time_dweek_list:insert{1, "Пн"}
    box.space.date_time_dweek_list:insert{2, "Вт"}
    box.space.date_time_dweek_list:insert{3, "Ср"}
    box.space.date_time_dweek_list:insert{4, "Чт"}
    box.space.date_time_dweek_list:insert{5, "Пт"}
    box.space.date_time_dweek_list:insert{6, "Сб"}
    box.space.date_time_dweek_list:insert{7, "Вс"}

    box.space.date_time_gnss:insert{1, false}

    box.space.date_time_videoserver:insert{1, false}

    box.space.date_time_sync:insert{1, false}

    box.space.date_time_activ:insert{1, false}

    box.space.date_time_format_date:insert{1, 3}

    box.space.date_time_format_date_list:insert{1, "МЕС/ДЕН/ГОД"}
    box.space.date_time_format_date_list:insert{2, "ГОД/МЕС/ДЕН"}
    box.space.date_time_format_date_list:insert{3, "ДЕН/МЕС/ГОД"}

    box.space.date_time_format_time:insert{1, 1}
    
    box.space.date_time_format_time_list:insert{1, "24 часа"}
    box.space.date_time_format_time_list:insert{2, "12 часов"}

    box.space.date_time_zone:insert{1, 2}

    box.space.date_time_zone_list:insert{1, "UTC+2 — Калининградское время"}
    box.space.date_time_zone_list:insert{2, "UTC+3 — Московское время"}
    box.space.date_time_zone_list:insert{3, "UTC+4 — Самарское время"}
    box.space.date_time_zone_list:insert{4, "UTC+5 — Екатеринбургское время"}
    box.space.date_time_zone_list:insert{5, "UTC+6 — Омское время"}
    box.space.date_time_zone_list:insert{6, "UTC+7 — Новосибирское время"}
    box.space.date_time_zone_list:insert{7, "UTC+8 — Иркутское время"}
    box.space.date_time_zone_list:insert{8, "UTC+9 — Якутское время"}
    box.space.date_time_zone_list:insert{9, "UTC+10 — Владивостокское время"}
    box.space.date_time_zone_list:insert{10, "UTC+11 — Среднеколымское время"}
    box.space.date_time_zone_list:insert{11, "UTC+12 — Камчатское время"}
    box.space.date_time_zone_list:insert{12, "UTC+13 — Самоа, Тонга"}
    box.space.date_time_zone_list:insert{13, "UTC+14 — Острова Лайн"}
    box.space.date_time_zone_list:insert{14, "UTC−12 — Линия перемены даты"}
    box.space.date_time_zone_list:insert{15, "UTC−11 — Американское Самоа"}
    box.space.date_time_zone_list:insert{16, "UTC−10 — Гавайи"}
    box.space.date_time_zone_list:insert{17, "UTC−9 — Аляска"}
    box.space.date_time_zone_list:insert{18, "UTC−8 — Североамериканское тихоокеанское"}
    box.space.date_time_zone_list:insert{19, "UTC−7 — Горное время (США и Канада)"}
    box.space.date_time_zone_list:insert{20, "UTC−6 — Центральное время (США и Канада)"}
    box.space.date_time_zone_list:insert{21, "UTC−5 — Североамериканское восточное время"}
    box.space.date_time_zone_list:insert{22, "UTC−4 — Атлантическое время (Канада)"}
    box.space.date_time_zone_list:insert{23, "UTC−3 — Южноамериканское восточное время"}
    box.space.date_time_zone_list:insert{24, "UTC−2 — Среднеатлантическое время"}
    box.space.date_time_zone_list:insert{25, "UTC+0 — Западноевропейское время"}
    box.space.date_time_zone_list:insert{26, "UTC+1 — Центральноевропейское время"}

end


function orbita_date_time.get_day()
    return os.date("%d")
end

function orbita_date_time.get_month()
    return os.date("%m")
end

function orbita_date_time.get_year()
    return os.date("%Y")
end

function orbita_date_time.get_hours()
    return os.date("%H")
end

function orbita_date_time.get_minutes()
    return os.date("%M")
end

function orbita_date_time.get_secundes()
    return os.date("%S")
end

function orbita_date_time.set_date(d,m,Y)
    return os.execute('date +%Y%m%d -s "'..Y..m..d..'"')
end

function orbita_date_time.set_time(H, M, S)
    return os.execute('date +%T -s "'..H..':'..M..':'..S..'"')
end


function orbita_date_time.get_add_list()
    return box.space.date_time_add_list:select{}
end

function orbita_date_time.get_add()
    return box.space.date_time_add:select{1}
end

function orbita_date_time.set_add(add_list_index)
    box.space.date_time_add:update({1}, {{'=', 2, add_list_index}})
end

function orbita_date_time.get_mode_list()
    return box.space.date_time_mode_list:select{}
end

function orbita_date_time.get_mode()
    return box.space.date_time_mode:select{1}
end

function orbita_date_time.set_mode(mode_list_index)
    box.space.date_time_mode:update({1}, {{'=', 2, mode_list_index}})
end

function orbita_date_time.get_date_time_winter()
    box.space.date_time_winter:select{1}
end    

function orbita_date_time.set_date_time_winter(from_month, from_week, from_dweek, from_time, to_month, to_week, to_dweek, to_time)
    box.space.date_time_winter:update({1}, 
        {
            {'=', 2, from_month },
            {'=', 3, from_week },
            {'=', 4, from_dweek },
            {'=', 5, from_time },
            {'=', 6, to_month },
            {'=', 7, to_week },
            {'=', 8, to_dweek },
            {'=', 9, to_time }
        }
    )
end    

function orbita_date_time.get_month_list()
    return box.space.date_time_month_list:select{}
end

function orbita_date_time.get_week_list()
    return box.space.date_time_week_list:select{}
end    

function orbita_date_time.get_dweek_list()
    return box.space.date_time_dweek_list:select{}
end 

function orbita_date_time.get_gnss()
    return box.space.date_time_gnss:select{1}
end

function orbita_date_time.set_gnss(is_checked)
    box.space.date_time_gnss:update({1}, {{'=', 2, is_checked}})
end

function orbita_date_time.get_videoserver()
    return box.space.date_time_videoserver:select{1}
end

function orbita_date_time.set_videoserver(is_checked)
    box.space.date_time_videoserver:update({1}, {{'=', 2, is_checked}})
end

function orbita_date_time.get_sync()
    return box.space.date_time_sync:select{1}
end

function orbita_date_time.set_sync(is_checked)
    box.space.date_time_sync:update({1}, {{'=', 2, is_checked}})
end

function orbita_date_time.get_avtiv()
    return box.space.date_time_avtiv:select{1}
end

function orbita_date_time.set_avtiv(is_checked)
    box.space.date_time_avtiv:update({1}, {{'=', 2, is_checked}})
end

function orbita_date_time.get_format_date()
    return box.space.date_time_format_date:select{1}
end

function orbita_date_time.set_format_date(format_date_index)
    box.space.date_time_format_date:update({1}, {{'=', 2, format_date_index}})
end

function orbita_date_time.get_format_date_list()
    return box.space.date_time_format_date_list:select{}
end

function orbita_date_time.get_format_time()
    return box.space.date_time_format_time:select{1}
end

function orbita_date_time.set_format_time(format_time_index)
    box.space.date_time_format_time:update({1}, {{'=', 2, format_time_index}})
end

function orbita_date_time.get_format_time_list()
    return box.space.date_time_format_time_list:select{}
end

function orbita_date_time.get_zone()
    return box.space.date_time_zone:select{1}
end

function orbita_date_time.set_zone(zone_index)
    box.space.date_time_zone:update({1}, {{'=', 2, zone_index}})
end

function orbita_date_time.get_zone_list()
    return box.space.date_time_zone_list:select{}
end

return orbita_date_time