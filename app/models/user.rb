class User < ApplicationRecord
  has_many :tokens
  has_many :invoices

  validates_uniqueness_of :email
end
