module Models

  class Task < Sequel::Model

    PENDING_STATUS = 0
    REJECTED_STATUS = 1
    COMPLETED_STATUS = 2


    many_to_one :user

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
