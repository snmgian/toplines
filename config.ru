require 'lib/engine'

G::Engine.new(:development).run

run Web::Toplines

# rackup
# http://localhost:9292/
