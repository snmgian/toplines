module Business
  module Tasks

    TOP_COUNT = 10

    def self.create(description, points, user)
      Models::Task.create(
        :description => description,
        :points => points,
        :status => Models::Task::PENDING_STATUS,
        :user => user
      )
    end

    def self.complete(task)
      task.update(:status => Models::Task::COMPLETED_STATUS)
    end

    def self.down(task, points = 1)
      task.update(:points => task.points - points)
    end

    def self.get(task_id)
      Models::Task.get!(task_id)
    rescue DataMapper::ObjectNotFoundError => e
      raise Business::TaskNotFoundError
    end

    def self.reject(task)
      task.update(:status => Models::Task::REJECTED_STATUS)
    end

    def self.top
      Models::Task.all(:order => :points.desc, :limit => TOP_COUNT)
    end

    def self.up(task, points = 1)
      task.update(:points => task.points + points)
    end

    def self.update(task, params)
      task.update(params)
    end
  end
end
