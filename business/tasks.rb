module Toplines
  module Business
    class Tasks
      def self.create(user)
        Task.create(:user => user, :status => Task::PENDING_STATUS)
      end
    end
  end
end
