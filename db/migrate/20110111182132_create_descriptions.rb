class CreateDescriptions < ActiveRecord::Migration
  def self.up
    create_table :descriptions do |t|
      t.string :name
      t.string :descriptionable_type
      t.integer :descriptionable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :descriptions
  end
end
