require 'sinatra'
require 'mysql2'
require 'aws-sdk'
require_relative 'local_ENV.rb'


client = Mysql2::Client.new(:host => ENV['endpoint'], :username => ENV['username'], :password => ENV['password'], :port => ENV['port'], :database => ENV['database'], :socket =>'/tmp/mysql.sock')

get '/' do
  erb :login
end

post '/login' do
username = params[:username]
password = params[:password]
end

get '/signup' do
  erb :signup
end

