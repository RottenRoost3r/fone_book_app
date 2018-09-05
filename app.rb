require 'sinatra'

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

