
class CreateProperties < ActiveRecord::Migration[8.1]
  def change
    create_table :properties do |t|
      t.references :user, null: false, foreign_key: true
      t.references :neighborhood, null: false, foreign_key: true
      t.string :address, null: false
      t.string :property_type, null: false
      t.integer :bedrooms, null: false
      t.integer :bathrooms, null: false
      t.text :shared_spaces

      t.timestamps
    end
  end
end
