class CreateLogins < ActiveRecord::Migration[7.1]
  def change
    create_table :logins do |t|
      t.string :device_id
      t.string :ip_address
      t.string :user_agent
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
