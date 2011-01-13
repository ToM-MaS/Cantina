class CreateVcards < ActiveRecord::Migration
  def self.up
    create_table :vcards do |t|
      t.string :name
      t.text :content
      t.integer :position
      t.string :vcardable_type
      t.integer :vcardable_id

      t.timestamps
    end
  end

  def self.down
    drop_table :vcards
  end
end
