require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark'
require 'uri'


class BookmarkManager < Sinatra::Base
  enable :sessions
  use Rack::MethodOverride
  register Sinatra::Flash

  get '/' do
    'page working!'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :index
  end

  get '/bookmarks/new' do
    erb :"bookmarks/new"
  end

  post '/bookmarks' do
    flash[:notice] = "You must enter a valid URL" unless Bookmark.create(url: params['url'], title: params['title'])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(params['id'])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    erb :"bookmarks/edit"
  end

  put '/bookmarks/:id/edit' do
    # SQL command to edit the entry by id
    redirect '/bookmarks'
  end

  run! if app_file ==$0
end
