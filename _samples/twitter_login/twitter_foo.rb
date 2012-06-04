require 'sinatra/base'

#Twitter::Login.new(
  #:consumer_key => 'AtE0BY2z371vYIWxQ4Xc8w', 
  #:secret => '6SBAdsPW33bsIuFnImXqCNtjEQO18osTKPF1EOnIyU'
#)

class TwitterFoo < Sinatra::Base
  get '/' do
    'Twitter FOO'
  end

  get '/authorized' do
    'You are authorized, welcome!'
  end
end

# ruby sinatra_foo.rb
