require 'sinatra'
require 'mysql2'

require_relative 'local_ENV.rb'
enable :sessions

load 'local_ENV.rb' if File.exist?('local_ENV.rb')
client = Mysql2::Client.new(:host => ENV['endpoint'], :username => ENV['username'], :password => ENV['password'], :port => ENV['port'], :database => ENV['database'], :socket =>'/tmp/mysql.sock')

get '/' do
  erb :login
end

post '/login' do
username = params[:username]
password = params[:password]
chk_arr = []
x = client.query("SELECT `id` FROM `users_table` WHERE username = '#{username}' AND password = '#{password}'")
x.each do |c|
  chk_arr << c['id']
end  
unless chk_arr.length > 0
  redirect '/'
end
session[:user_id] = chk_arr.join('')
redirect '/contacts'
end

get '/signup' do
  erb :signup
end

post '/signup' do
username = params[:username]
password = params[:password]

client.query("INSERT INTO `users_table`(id, username, password) VALUES(UUID(), '#{username}', '#{password}')")
redirect '/'
end

get '/contacts' do
erb :contacts
end

post '/contacts' do
end