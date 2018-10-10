require 'mysql2'


load 'local_ENV.rb' if File.exist?('local_ENV.rb')
client = Mysql2::Client.new(:host => ENV['endpoint'], :username => ENV['username'], :password => ENV['password'], :port => ENV['port'], :database => ENV['database'], :socket =>'/tmp/mysql.sock')

def login_funk(client, username, password)
    chk_arr = []

    x = client.query("SELECT `id` FROM `users_table` WHERE username = '#{username}' AND password = AES_ENCRYPT('#{password}', UNHEX(SHA2('#{ENV['salt']}',512)))")
    
    x.each do |c|
        chk_arr << c['id']
    end
    
    session[:user_id] = chk_arr.join('')
    
    
    unless chk_arr.length > 0
        session[:error] = "Invalid Username or Password"
        redirect '/'
    else chk_arr.length <= 0
        session[:error] = ""
    end
end

def create_un(client, username, password)
    client.query("INSERT INTO `users_table`(id, username, password) VALUES(UUID(), '#{username}', AES_ENCRYPT('#{password}', UNHEX(SHA2('#{ENV['salt']}',512))))")
end

def unique_user(client, username, password)
    m = client.query("SELECT `username` FROM users_table")
    m.each do |v|
    if v.has_value?(username)
        session[:error] = "Username Already Taken"
        redirect '/signup'
    else
        session[:error] = ""
    end
    end
end

def create_con(client, firstname, lastname, street, city, state, zip, phonenumber, id)
    client.query("INSERT INTO `contacts_table`(firstname, lastname, street, city, state, zip, phonenumber, owner) VALUES('#{First_Name}', '#{Last_Name}', '#{Street_Address}', '#{City}', '#{State}', '#{Zip}', '#{Phone_Number}', '#{id}')")
end


