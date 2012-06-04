module Toplines
  module Business
    class Tasks

      def self.complete(task)
        task.update(:status => Task::COMPLETED_STATUS)
      end

      def self.create(description, points, user)
        Task.create(
          :description => description,
          :points => points,
          :status => Task::PENDING_STATUS,
          :user => user
        )
      end

      def self.reject(task)
        task.update(:status => Task::REJECTED_STATUS)
      end
    end
  end
end
