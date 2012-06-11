require 'logger'
require 'rspec'
require 'sequel'

require_relative '../db/schema.rb'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

db = Sequel.connect('jdbc:mysql://localhost/toplines?user=root&password=root', 
                   :logger => Logger.new('db.log'))

RSpec.configure do |config|
  config.before(:suite) do

    Toplines::DB.create_schema(db)

    Dir[File.dirname(__FILE__) + "/../models/**/*.rb"].each {|f| require f}
    Dir[File.dirname(__FILE__) + "/../exceptions/**/*.rb"].each {|f| require f}
  end
end
