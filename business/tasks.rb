module Toplines
  module Business
    class Tasks

      def self.create(description, points, user)
        Task.create(
          :description => description,
          :points => points,
          :status => Task::PENDING_STATUS,
          :user => user
        )
      end

      def self.complete(task)
        task.update(:status => Task::COMPLETED_STATUS)
      end

      def self.down(task, points = 1)
        # TODO: check for data integrity
        task.update(:points => task.points - points)
      end

      def self.get(task_id)
        Task.get!(task_id)
      rescue DataMapper::ObjectNotFoundError => e
        raise Toplines::Business::TaskNotFoundError
      end

      def self.reject(task)
        task.update(:status => Task::REJECTED_STATUS)
      end

      def self.up(task, points = 1)
        # TODO: check for data integrity
        task.update(:points => task.points + points)
      end
    end
  end
end
