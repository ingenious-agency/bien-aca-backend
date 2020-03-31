# frozen_string_literal: true

class CreateHeartbeats < ActiveRecord::Migration[6.0]
  def change
    create_table :heartbeats do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :time, null: false
      t.boolean :within_fence
      t.decimal :fence_diameter
      t.jsonb :data
      t.decimal :lat, null: false
      t.decimal :lng, null: false
      t.timestamps
    end
  end
end
