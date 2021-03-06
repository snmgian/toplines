require 'lib/engine'

RSpec.configure do |config|

  config.around(:each) do |example|
    DataMapper::Transaction.new(DataMapper.repository).commit do |t|
      example.run
      t.rollback
    end
  end

end

engine = G::Engine.new(:test)
engine.run
