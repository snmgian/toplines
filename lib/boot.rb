require_relative 'environment'
require_relative 'engine'


module G
  module Boot
    def self.strap
      # loads config
      # setups engine
      # runs the engine
      G::Environment.load(ENV['G_ENV'])

      engine = G::Engine.new
      engine.register G::DataMapperEngine
      engine.run
    end
  end
end
