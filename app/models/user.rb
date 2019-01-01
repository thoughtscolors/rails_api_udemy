class User < ApplicationRecord
  include BCrypt

  validates :login, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :password, presence: true, if: -> { provider == 'standard' }

  has_one :access_token, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  def password
    # including BCrypt allows Password class to be referenced directly, otherwise it would be BCrypt::Password
    @password ||= Password.new(encrypted_password) if encrypted_password.present?
  end

  def password=(new_password)
    #this handles if password is nil, otherwise BCrypt would still hash
    return @password = new_password if new_password.blank?

    @password = Password.create(new_password)
    self.encrypted_password = @password
  end
end
