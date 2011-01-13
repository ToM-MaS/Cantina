class CreateSipAccounts < ActiveRecord::Migration
  def self.up
    create_table :sip_accounts do |t|
      t.string :name
      t.string :auth_user
      t.string :user
      t.string :password
      t.string :registrar
      t.integer :registrar_port
      t.string :outbound_proxy
      t.integer :outbound_proxy_port
      t.string :sip_proxy
      t.integer :sip_proxy_port
      t.string :realm
      t.string :screen_name
      t.string :display_name
      t.integer :registration_expiry_time
      t.string :dtmf_mode
      t.string :remote_password
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :sip_accounts
  end
end
