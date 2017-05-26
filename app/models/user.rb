class User < ApplicationRecord
  # has_secure_password is a built-in rails method that provides
  # user authentication features for the model its called in
  # 1. It will automatically add a presence validator for password
  #    field
  # 2. When given a password, it will generate a salt, then it will hash
  #    the salt and password combo then store the rsult into the database
  #    field (using the gem `bcrypt`)
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
             uniqueness: { case_sensitive: false },
             format: VALID_EMAIL_REGEX
end
