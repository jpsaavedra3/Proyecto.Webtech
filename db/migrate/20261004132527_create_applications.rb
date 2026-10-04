
class CreateApplications < ActiveRecord::Migration[8.1]
  def change
    create_table :applications do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :message, null: false
      t.date :move_in_date, null: false
      t.integer :intended_stay_months, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :applications, [ :listing_id, :user_id ], unique: true
  end
end
