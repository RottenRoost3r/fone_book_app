require 'mysql2'
require_relative 'local_ENV.rb'

load 'local_ENV.rb' if File.exist?('local_ENV.rb')
client = Mysql2::Client.new(:host => ENV['endpoint'], :username => ENV['username'], :password => ENV['password'], :port => ENV['port'], :database => ENV['database'], :socket =>'/tmp/mysql.sock')

def create_un(client, username, password)
    client.query("INSERT INTO `users_table`(id, username, password) VALUES(UUID(), '#{username}', AES_ENCRYPT('#{password}', UNHEX(SHA2('#{ENV['salt']}',512))))")
end

