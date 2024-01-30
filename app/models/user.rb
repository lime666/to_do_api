# frozen_string_literal: true

class User < ApplicationRecord
  PASSWORD_REGEXP = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*\W).{8,}\z/

  has_secure_password
  has_many :projects, dependent: :destroy
  has_many :tasks, through: :projects

  validates :email, :password, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, format: { with: PASSWORD_REGEXP }
end
