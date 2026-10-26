class RemoveDescriptionAndHouseRulesFromListings < ActiveRecord::Migration[8.1]
  def change
    remove_column :listings, :description, :text, null: false
    remove_column :listings, :house_rules, :text
  end
end
