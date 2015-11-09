require 'json'
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'

configure :development, :test do
  require 'pry'
end

configure do
  set :views, 'app/views'
end

after do
  ActiveRecord::Base.connection.close
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
  @ids = Item.pluck(:html_identifier)
  erb :admin
end

post '/admin' do
  identifiers = Item.all.pluck(:html_identifier)
  if identifiers.include?(params[:item])
    i = Item.find_by(html_identifier: params[:item])
    i.content = params[:content]
    i.save
  end
  redirect '/admin'
end

get '/items' do
  @items = []
  Item.find_each do |i|
    @items << {
      html_identifier: i.html_identifier,
      content: i.content
    }
  end
  @items.to_json
end
