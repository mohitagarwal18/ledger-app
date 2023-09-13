class Entity < ApplicationRecord
  has_many :transactions

  enum entity_type: { INVESTOR: 0, OTHER_TYPE: 1 }
end
