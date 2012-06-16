require 'sinatra/base'
require 'slim'

require 'business/tasks'
require 'models/task'

module Web
  class Toplines < Sinatra::Base

    get '/' do
      @message = 'SUCCESS'
      @tasks = Business::Tasks.top

      slim :index
    end
    
  end
end

