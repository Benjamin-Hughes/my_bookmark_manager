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
    params[:tags].split.each do |tag| # Splits each tag and creates tag objects for them
      link.tags << Tag.first_or_create(name: tag) # Creates the relationship between tags and links
    end
    link.save # saves the relationship created above to the database
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

end
