class CreateManufacturerOuis < ActiveRecord::Migration
  def self.up
    create_table :manufacturer_ouis do |t|
      t.string :oui
      t.integer :manufacturer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :manufacturer_ouis
  end
end
