ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    # Create a new row in the database and use the input from the forms
    link = Link.new(url: params[:url], title: params[:title])
    tag = Tag.first_or_create(name: params[:tags]) #Can this be done inside the Link.new call?
    link.tags << tag # creates the relationship betwen link and tag
    link.save # saves the relationship created above to the database
    redirect to('/links')
  #   Link.create(url: params[:url], title: params[:title])
  #   redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

end
