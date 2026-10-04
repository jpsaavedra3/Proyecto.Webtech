class CreateReports < ActiveRecord::Migration[8.1]
  def change
    create_table :reports do |t|
      t.references :listing, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :reason, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
