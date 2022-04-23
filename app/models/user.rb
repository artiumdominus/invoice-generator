class User < ApplicationRecord
  has_many :tokens

  validates_uniqueness_of :email
end