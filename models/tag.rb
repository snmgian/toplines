module Models
  class Tag
    include DataMapper::Resource

    property :id,         Serial
    property :name,       String
  end
end
