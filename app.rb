require 'sinatra'
require 'mysql2'

require_relative 'local_ENV.rb'

load 'local_ENV.rb' if File.exist?('local_ENV.rb')
client = Mysql2::Client.new(:host => ENV['endpoint'], :username => ENV['username'], :password => ENV['password'], :port => ENV['port'], :database => ENV['database'], :socket =>'/tmp/mysql.sock')

get '/' do
  p client
  erb :login
end

post '/login' do
username = params[:username]
password = params[:password]
end

get '/signup' do
  erb :signup
end

post '/signup' do
username = params[:username]
password = params[:password]

client.query("INSERT INTO `users_table`(id, username, password) VALUES(UUID(), '#{username}' '#{password}')")

end
