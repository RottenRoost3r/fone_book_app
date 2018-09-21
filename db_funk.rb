require 'mysql2'
require_relative 'local_ENV.rb'

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
    redirect '/'
    end
end

def create_un(client, username, password)
    client.query("INSERT INTO `users_table`(id, username, password) VALUES(UUID(), '#{username}', AES_ENCRYPT('#{password}', UNHEX(SHA2('#{ENV['salt']}',512))))")
end

