require 'sinatra/base'

class TwitterFoo < Sinatra::Base
  get '/' do
    'Twitter FOO'
  end

  get '/authorized' do
    'You are authorized, welcome!'
  end
end
