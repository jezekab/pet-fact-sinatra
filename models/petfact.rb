class PetFact
  include Mongoid::Document
  field :fact, type: String

  validates :fact, presence: true

end