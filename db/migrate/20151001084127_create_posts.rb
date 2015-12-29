class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :Name
      t.string :Email
      t.text :message
      t.references :topic, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
