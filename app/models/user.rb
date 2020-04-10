# frozen_string_literal: true

class User < ApplicationRecord
  enum gender: { male: 0, female: 1 }
  has_secure_password
  acts_as_mappable
  has_many :heartbeats, dependent: :restrict_with_exception
  has_many :authentication_proofs, dependent: :restrict_with_exception

  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true
  validates :identity_number, presence: true
  validates :date_of_birth, presence: true
  validates :gender, presence: true
  validates :cellphone, presence: true
  validates :lat, presence: true
  validates :lng, presence: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  scope :outside_fence, -> { where(within_fence: false) }
  scope :not_authenticated, -> { where(last_authentication: false) }
end
