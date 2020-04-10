# frozen_string_literal: true

class CreateAuthenticationProofs < ActiveRecord::Migration[6.0]
  def change
    create_table :authentication_proofs do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :time
      t.boolean :authenticated

      t.timestamps
    end
    change_table :users do |t|
      t.boolean :last_authentication, default: false
    end
  end
end
