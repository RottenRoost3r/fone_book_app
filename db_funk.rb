require 'mysql2'
require_relative 'local_ENV.rb'

load 'local_ENV.rb' if File.exist?('local_ENV.rb')


def create_un(client, username, password)
   client.query("INSERT INTO `users_table`(id, username, password) VALUES(UUID(), '#{username}', '#{password}')")
end

