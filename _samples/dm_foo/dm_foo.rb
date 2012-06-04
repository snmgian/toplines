require 'data_mapper'
require 'dm-migrations'

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, 'mysql://root:root@localhost/toplines')

class Tag
  include DataMapper::Resource

  property :id,         Serial
  property :name,       String
end

DataMapper.finalize

DataMapper.auto_upgrade!

@fun = Tag.create(
  :name => 'fun',
)


