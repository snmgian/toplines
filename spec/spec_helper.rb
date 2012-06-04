require 'data_mapper'
require 'dm-migrations'
require 'rspec'


Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
    DataMapper::Logger.new($stdout, :debug)

    Dir[File.dirname(__FILE__) + "/../models/**/*.rb"].each {|f| require f}

    DataMapper.finalize

    DataMapper.setup(:default, 'mysql://root:root@localhost/toplines')
    DataMapper.auto_migrate!
  end
end
