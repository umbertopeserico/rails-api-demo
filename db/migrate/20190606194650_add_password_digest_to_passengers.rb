class AddPasswordDigestToPassengers < ActiveRecord::Migration[5.2]
  def change
    add_column :v1_passengers, :password_digest, :string, default: '', null: false
  end
end
