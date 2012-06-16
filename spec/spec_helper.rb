require 'rspec'

require 'lib/engine'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
    engine = G::Engine.new(:test)
    engine.run
  end

  config.around(:each) do |example|
    DataMapper.repository(:default).transaction do |t|
      example.run
      t.rollback
    end
  end
end
