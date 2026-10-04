
class CreateListings < ActiveRecord::Migration[8.1]
  def change
    create_table :listings do |t|
      t.references :property, null: false, foreign_key: true
      t.decimal :monthly_rent, null: false
      t.decimal :deposit, null: false
      t.date :available_from, null: false
      t.integer :minimum_stay_months, null: false
      t.boolean :furnished, null: false, default: false
      t.boolean :private_bathroom, null: false, default: false
      t.text :description, null: false
      t.text :house_rules
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
