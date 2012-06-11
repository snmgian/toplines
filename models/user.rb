module Toplines
  module Models

    class User < Sequel::Model
      one_to_many :tasks
    end

  end
end
