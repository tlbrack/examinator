# frozen_string_literal: true

# Create users
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number

      t.index %i[first_name last_name phone_number], unique: true

      t.timestamps
    end
  end
end
