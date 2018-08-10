require 'sinatra'

module Carraway
  class Server < Sinatra::Base
    set :views, File.expand_path('../views', __FILE__)

    get '/' do
      @categories = Category.all
      @category_posts = Post.all.group_by {|post| post.category.key }
      erb :top
    end

    get '/new' do
      erb :new
    end

    post '/' do
      Post.create(
        title: params[:title],
        path: params[:path],
        body: params[:body],
        category_key: params[:category]
      )
      'Created!'
    end
  end
end
