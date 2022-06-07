# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :password_digest, presence: true
  validates_length_of :password, minimum: 8
  validates :password_confirmation, presence: true
  validates_uniqueness_of :email, case_sensitive: false

  def self.authenticate_with_credentials(email, password)
    user = User.find_by('email ILIKE ?', email.strip)&.authenticate(password)
    return user if user

    nil
  end
end
