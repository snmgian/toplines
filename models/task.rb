class Task
  include DataMapper::Resource

  PENDING_STATUS = 0

  property :id,         Serial
  property :name,       String
  property :status,     Integer

  belongs_to :user

  def pending?
    self.status == PENDING_STATUS
  end
end
