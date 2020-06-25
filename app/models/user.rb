class User < ActiveRecord::Base
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :firstName, presence: true, length: { in: 2..60 }
  validates :lastName, presence: true, length: { in: 2..60 }
  
  # validates :password, presence: true, on: :create
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }

  has_many :playlists
  has_many :songs, through: :playlists
  # has_many :secrets
  # has_many :likes, dependent: :destroy
  # has_many :secrets_liked, through: :likes, source: :secret
    
  # validates_email_format_of :email

  private

  before_validation :email_to_lowercase

  def email_to_lowercase
    self.email.downcase
  end

end
