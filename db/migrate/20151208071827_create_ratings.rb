class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :star
      t.integer :post

      t.timestamps null: false
    end
  end
end
