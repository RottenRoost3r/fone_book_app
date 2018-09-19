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

chk_arr = []

x = client.query("SELECT `id` FROM `users_table` WHERE username = '#{username}' AND password = AES_ENCRYPT('#{password}', UNHEX(SHA2('#{ENV['salt']}',512)))")
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
username = client.escape(username)
password = client.escape(password)


m = client.query("SELECT `username` FROM users_table")
m.each do |v|
  if v.has_value?(username)
    redirect '/signup'
  end
end

client.query("INSERT INTO `users_table`(id, username, password) VALUES(UUID(), '#{username}', AES_ENCRYPT('#{password}', UNHEX(SHA2('#{ENV['salt']}',512))))")

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
    contacts << arr
  end
  p contacts
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
  client.query("INSERT INTO `contacts_table`(firstname, lastname, street, city, state, zip, phonenumber, owner) VALUES('#{First_Name}', '#{Last_Name}', '#{Street_Address}', '#{City}', '#{State}', '#{Zip}', '#{Phone_Number}', '#{id}')")
 
  redirect '/contacts'
end