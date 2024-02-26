class CreateCertificates < ActiveRecord::Migration[7.1]
  def change
    create_table :certificates do |t|
      t.string :title
      t.integer :source, null: false, default: 0
      t.datetime :date_awarded
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
