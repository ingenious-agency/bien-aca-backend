# frozen_string_literal: true

class AuthenticationProof < ApplicationRecord
  belongs_to :user

  validates :time, presence: true

  after_save :update_user

  private

  # rubocop:disable Rails/SkipsModelValidations
  def update_user
    user.update_columns({ last_authentication: authenticated })
  end
  # rubocop:enable Rails/SkipsModelValidations
end
