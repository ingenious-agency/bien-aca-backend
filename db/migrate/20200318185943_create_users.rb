# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :password_digest
      t.string :name, null: false
      t.string :identity_number, null: false
      t.datetime :date_of_birth, null: false
      t.integer :gender, null: false, default: 0
      t.string :cellphone, null: false
      t.string :other_phone
      t.boolean :within_fence
      t.decimal :fence_diameter, default: 1.0 # 1km
      t.decimal :lat, null: false
      t.decimal :lng, null: false
      t.timestamps
    end
  end
end
