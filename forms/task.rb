module Forms
  class Task < Foraneus::ValueSet
    include Foraneus::HashlikeValueSet

    integer       :id
    string        :description
    integer       :points
    integer       :status
  end
end
