local orbita_auth = {}

function orbita_auth.init()
    orbita_auth.create_user('root', 'root')
    orbita_auth.set_admin('root')
end

function orbita_auth.set_admin(username)
    box.schema.user.grant(username, 'read,write,execute','universe')
end

function orbita_auth.create_user(username, pwd)
    box.schema.user.create(username, {password = pwd})
end

function orbita_auth.delete_user(username)
    box.schema.user.drop(username)
end

function orbita_auth.auth(username, password)
    print(username)
    if box.schema.user.exists(username)
        then
            return true
        else
            return false
        end
end
    
function orbita_auth.set_password(username, password)
    box.schema.user.passwd(username, password)
end

function orbita_auth.get_user(username)
 return box.space._user.index.name:select{username}
end

return orbita_auth