# frozen_string_literal: true

class Heartbeat < ApplicationRecord
  belongs_to :user, optional: true
  acts_as_mappable

  validates :time, presence: true
  validates :lat, presence: true
  validates :lng, presence: true

  after_save :calculate_fence

  private

  # rubocop:disable Rails/SkipsModelValidations
  def calculate_fence
    within_fence = Heartbeat.within(user.fence_diameter,
                                    origin: [user.lat, user.lng]).to_a.include?(self)
    update_columns({ within_fence: within_fence, fence_diameter: user.fence_diameter })
    user.update_columns({ within_fence: within_fence })
  end
  # rubocop:enable Rails/SkipsModelValidations
end
