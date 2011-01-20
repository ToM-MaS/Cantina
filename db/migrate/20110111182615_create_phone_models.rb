class CreatePhoneModels < ActiveRecord::Migration
  def self.up
    create_table :phone_models do |t|
      t.string :name
      t.string :url
      t.integer :manufacturer_id
      t.integer :max_number_of_sip_accounts
      t.integer :number_of_keys
      t.integer :max_number_of_phone_book_entries
      t.string :default_http_user
      t.string :default_http_password

      t.timestamps
    end
  end

  def self.down
    drop_table :phone_models
  end
end
