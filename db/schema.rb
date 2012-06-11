module Toplines
  module DB
    def self.create_schema(db)
      db.create_table! :tags do
        primary_key :id

        String :name
      end

      db.create_table! :tasks do
        primary_key :id

        String :description
        Integer :points
        Integer :status

        foreign_key :user_id, :users
      end

      db.create_table! :users do
        primary_key :id
      end
    end
  end
end
