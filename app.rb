require 'sinatra'
require 'mysql2'
require 'sanitize'
require_relative 'local_ENV.rb'
require_relative 'db_funk.rb'
enable :sessions

load 'local_ENV.rb' if File.exist?('local_ENV.rb')
client = Mysql2::Client.new(:host => ENV['endpoint'], :username => ENV['username'], :password => ENV['password'], :port => ENV['port'], :database => ENV['database'], :socket =>'/tmp/mysql.sock')

get '/' do
  error = session[:error] || ""
  erb :login
end

post '/login' do
username = params[:username]
password = params[:password]
username = client.escape(username)
password = client.escape(password)

login_funk(client, username, password)

redirect '/contacts'

end

get '/signup' do
  erb :signup
end

post '/signup' do
username = params[:username]
password = params[:password]
username = client.escape(username)
password = client.escape(password)

unique_user(client, username, password)

create_un(client, username, password)
redirect '/'
end

get '/contacts' do
  contacts = []
  n = client.query("SELECT * FROM `contacts_table` WHERE owner = '#{session[:user_id]}'")
  n.each do |y|
    arr = []
    arr << Sanitize.clean(y['firstname'])
    arr << Sanitize.clean(y['lastname'])
    arr << Sanitize.clean(y['street'])
    arr << Sanitize.clean(y['city'])
    arr << Sanitize.clean(y['state'])
    arr << Sanitize.clean(y['zip'])
    arr << Sanitize.clean(y['phonenumber'])
    arr << (y['id'])
    contacts << arr
  end
erb :contacts, locals:{contacts: contacts || []}
end

post '/contacts' do

end

get '/create_contact' do
  erb :create_contact
end

post '/create_contact' do
  First_Name = params[:firstname]
  First_Name = client.escape(First_Name)
  Last_Name = params[:lastname]
  Last_Name = client.escape(Last_Name)
  Street_Address = params[:street]
  Street_Address = client.escape(Street_Address)
  City = params[:city]
  City = client.escape(City)
  State = params[:state]
  State = client.escape(State)
  Phone_Number = params[:phonenumber]
  Phone_Number = client.escape(Phone_Number)
  Zip = params[:zip]
  Zip = client.escape(Zip)
  id = session[:user_id]
  id = client.escape(id)
  create_con(client, First_Name, Last_Name, Street_Address, City, State, Zip, Phone_Number, id)
 
  redirect '/contacts'
end

get '/update' do
  erb :update
end

post '/update' do
  First_Name = params[:firstname]
  First_Name = client.escape(First_Name)
  Last_Name = params[:lastname]
  Last_Name = client.escape(Last_Name)
  Street_Address = params[:street]
  Street_Address = client.escape(Street_Address)
  City = params[:city]
  City = client.escape(City)
  State = params[:state]
  State = client.escape(State)
  Phone_Number = params[:phonenumber]
  Phone_Number = client.escape(Phone_Number)
  Zip = params[:zip]
  Zip = client.escape(Zip)
  id = session[:user_id]
  id = client.escape(id)
  special_id = params[:up_button]

  puts "#{up_button}"
  redirect'/contacts'
end