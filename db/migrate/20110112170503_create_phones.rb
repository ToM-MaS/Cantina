class CreatePhones < ActiveRecord::Migration
  def self.up
    create_table :phones do |t|
      t.string :mac_address
      t.integer :phone_model_id
      t.string :ip_address

      t.timestamps
    end
  end

  def self.down
    drop_table :phones
  end
end
