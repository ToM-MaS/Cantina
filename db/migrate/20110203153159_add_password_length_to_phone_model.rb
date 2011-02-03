class AddPasswordLengthToPhoneModel < ActiveRecord::Migration
  def self.up
    add_column :phone_models, :random_password_length, :integer
    add_column :phone_models, :random_password_contains_of, :string
  end

  def self.down
    remove_column :phone_models, :random_password_contains_of
    remove_column :phone_models, :random_password_length
  end
end
