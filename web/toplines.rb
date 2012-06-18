require 'sinatra/base'
require 'slim'

require 'business/tasks'
require 'models/task'

module Web
  class Toplines < Sinatra::Base

    get '/' do
      @message = 'SUCCESS'
      @tasks = Business::Tasks.top

      p @tasks
      slim :index
    end

    post '/tasks/:id/complete' do
      task = Business::Tasks.get(params[:id])
      Business::Tasks.complete(task)

      redirect to('/')
    end

    post '/tasks/:id/down' do
      task = Business::Tasks.get(params[:id])
      Business::Tasks.down(task)

      redirect to('/')
    end
    
    get '/tasks/:id/edit' do
      @task = Business::Tasks.get(params[:id])
      slim :edit
    end
    
    post '/tasks/:id/edit' do
      p params
      p params.class
      ps = params.select { |k, v| [:id, :description, :points, :status].include?(k.to_sym) }
      p ps
      task = Business::Tasks.get(ps['id'])
      Business::Tasks.update(task, ps)

      redirect to('/')
    end

    post '/tasks/:id/reject' do
      task = Business::Tasks.get(params[:id])
      Business::Tasks.reject(task)

      redirect to('/')
    end

    post '/tasks/:id/up' do
      task = Business::Tasks.get(params[:id])
      Business::Tasks.up(task)

      redirect to('/')
    end
    
  end
end

