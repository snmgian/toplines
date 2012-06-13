require 'data_mapper'
require 'sinatra/base'
require 'slim'

require 'business/tasks'
require 'models/task'

DataMapper::Logger.new($stdout, :debug)

Dir[File.dirname(__FILE__) + "/../models/**/*.rb"].each {|f| require f}
Dir[File.dirname(__FILE__) + "/../exceptions/**/*.rb"].each {|f| require f}

DataMapper.finalize

DataMapper.setup(:default, 'mysql://root:root@localhost/toplines')
DataMapper.auto_upgrade!

module Web
  class Toplines < Sinatra::Base

    get '/' do
      @message = 'SUCCESS'
      @tasks = Business::Tasks.top

      slim :index
    end
    
  end
end

