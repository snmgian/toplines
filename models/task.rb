module Models
  class Task
    include DataMapper::Resource

    PENDING_STATUS = 0
    REJECTED_STATUS = 1
    COMPLETED_STATUS = 2

    property :id,           Serial
    property :description,  String
    property :points,       Integer
    property :status,       Integer

    belongs_to :user, :required => false

    def completed?
      self.status == COMPLETED_STATUS
    end

    def pending?
      self.status == PENDING_STATUS
    end

    def rejected?
      self.status == REJECTED_STATUS
    end
  end
end
