require 'sinatra/base'
require 'slim'

module Web
  class Toplines < Sinatra::Base

    get '/' do
      @tasks = Business::Tasks.top

      slim :index
    end

    get '/tasks/new' do
      @task = Models::Task.new
      slim :new
    end

    post '/tasks/new' do
      form = Forms::Task.build!(params)

      Business::Tasks.create(
        form.description,
        form.points,
        nil
      )

      redirect to('/')
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
      form = Forms::Task.build!(params)
      task = Business::Tasks.get(form.id)

      Business::Tasks.update(task, form[:as_hash])

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

