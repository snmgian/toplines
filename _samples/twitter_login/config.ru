require 'twitter/login'

require './twitter_foo'

twitter = Twitter::Login.new({
  :consumer_key => 'AtE0BY2z371vYIWxQ4Xc8w', 
  :secret => '6SBAdsPW33bsIuFnImXqCNtjEQO18osTKPF1EOnIyU'
})

twitter_login = twitter.login_handler(:return_to => '/authorized')

use Rack::Session::Cookie

run Rack::URLMap.new "/" => TwitterFoo,
                     "/authenticate" => twitter_login
