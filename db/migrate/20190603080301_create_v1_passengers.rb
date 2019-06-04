# frozen_string_literal: true

class CreateV1Passengers < ActiveRecord::Migration[5.2]
  def change
    create_table :v1_passengers, id: false do |t|
      t.string :id, primary_key: true, null: false
      t.timestamps

      t.string :first_name
      t.string :last_name
      t.string :email, null: false
    end

    add_index :v1_passengers, 'LOWER(email)', unique: true, name: :index_v1_passengers_on_LOWER_email
  end
end
