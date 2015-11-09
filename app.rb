require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'

configure :development, :test do
  require 'pry'
end

configure do
  set :views, 'app/views'
end

Dir[File.join(File.dirname(__FILE__), 'app', '**', '*.rb')].each do |file|
  require file
  also_reload file
end

get '/' do
  @items = {}
  Item.find_each do |i|
    @items[i.html_identifier.to_sym] = i.content
  end
  erb :index
end

get '/admin' do
  @items = Item.all
  erb :admin
end
