require 'sinatra'
require 'slim'

get '/' do
  @message = 'Sinatra Slim FOO'
  slim :index
end

# ruby slim.rb
