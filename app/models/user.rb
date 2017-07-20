class User < ApplicationRecord
  has_secure_password

  validates :username, :uniqueness => true, :presence => true
  validates :full_name, :presence => true
  validates :password, :presence => true
end
