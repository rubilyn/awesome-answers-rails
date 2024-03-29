class User < ApplicationRecord
  # has_secure_password is a built-in rails method that provides
  # user authentication features for the model its called in
  # 1. It will automatically add a presence validator for password
  #    field
  # 2. When given a password, it will generate a salt, then it will hash
  #    the salt and password combo then store the rsult into the database
  #    field (using the gem `bcrypt`)
  # 3. If you skip `password_confirmation` field, then it won't give you
  #    a validation error for that. If you providate a `password_confirmation`,
  #   it will validate the password against it
  # 4. The user instance gets the method `authenticate` which will allow
  #    to verify if a user entered a the correct password. It returns the user
  #    if correct otherwise it returns `nil`
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: VALID_EMAIL_REGEX,
                    unless: :from_omniauth?

  before_create :generate_api_key
  before_validation :downcase_email

  has_many :questions, dependent: :nullify

  has_many :likes, dependent: :destroy
  has_many :liked_questions, through: :likes, source: :question

  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  # serialize :omniauth_raw_data means that when ActiveRecord writes to
  # this column it will transform an object into a string.
  # When we read that column, it will transform the string back into the original
  # object.
  serialize :oauth_raw_data

  def self.create_from_omniauth(omniauth_data)
    full_name = omniauth_data["info"]["name"].split
    User.create(
      uid: omniauth_data["uid"],
      provider: omniauth_data["provider"],
      first_name: full_name.first,
      last_name: full_name.last,
      oauth_token: omniauth_data["credentials"]["token"],
      oauth_secret: omniauth_data["credentials"]["secret"],
      oauth_raw_data: omniauth_data,
      password: SecureRandom.hex(32)
    )
  end

  def self.find_from_omniauth(omniauth_data)
    User.find_by(provider: omniauth_data["provider"], uid: omniauth_data["uid"])
  end

  # sometimes if an oauth application changes its permissions, the User
  # will be asked again for authorization. If this happens, the user will
  # new oauth credentials. We need to update the user in that situation.
  def update_oauth_credentials(omniauth_data)
    token = omniauth_data['credentials']['token']
    secret = omniauth_data['credentials']['secret']

    if oauth_token != token || oauth_secret != secret
      self.update oauth_token: token, oauth_secret: secret
    end
  end

  def from_omniauth?
    uid.present? && provider.present?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  # You can the .send method to call private methods
  # This should avoided in code, but useful in a pinch when
  # when working in the console. It can also be
  # used to dynamically call a method from a string.
  # u = User.last
  # u.send(:generate_api_key)
  def generate_api_key

    loop do
      # SecureRandom.hex(32) will generate a 32 byte
      # string of random hex characters
      self.api_key = SecureRandom.hex(32)
      # We then check that no user already posses that
      # api_key. If no user has that key, exit the loop.
      break unless User.exists?(api_key: api_key)
    end
  end

  def downcase_email
    self.email&.downcase!
  end
end
