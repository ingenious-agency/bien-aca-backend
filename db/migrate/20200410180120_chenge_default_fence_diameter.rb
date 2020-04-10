# frozen_string_literal: true

class ChengeDefaultFenceDiameter < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:users, :fence_diameter, 0.15)
  end
end
