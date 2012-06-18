require 'lib/engine'
require 'irb'

module Toplines
  class Console
    def self.start
      G::Engine.new(:development).run
      IRB.start
    end
  end
end
