require 'sinatra'
require 'slim'

get '/' do
  @message = 'Sinatra Slim FOO'
  slim :index
end

# ruby slim_foo.rb
# http://localhost:4567/
