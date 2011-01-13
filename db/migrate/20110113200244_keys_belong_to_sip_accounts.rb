class KeysBelongToSipAccounts < ActiveRecord::Migration
  def self.up
    add_column :phone_keys, :sip_account_id, :integer
    remove_column :phone_keys, :phone_id
  end

  def self.down
    add_column :phone_keys, :phone_id, :integer
    remove_column :phone_keys, :sip_account_id
  end
end
