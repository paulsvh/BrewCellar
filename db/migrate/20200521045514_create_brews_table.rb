class CreateBrewsTable < ActiveRecord::Migration
  def change
    create_table :brews do |t|
      t.string :brewery
      t.string :beer_name
      t.string :package_date
      t.string :abv
      t.integer :user_id
    end
  end
end
