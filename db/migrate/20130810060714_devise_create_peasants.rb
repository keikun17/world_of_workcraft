class DeviseCreatePeasants < ActiveRecord::Migration
  def self.up
    create_table(:peasants) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :peasants, :email,                :unique => true
    add_index :peasants, :reset_password_token, :unique => true
    # add_index :peasants, :confirmation_token,   :unique => true
    # add_index :peasants, :unlock_token,         :unique => true
    # add_index :peasants, :authentication_token, :unique => true
  end

  def self.down
    drop_table :peasants
  end
end
