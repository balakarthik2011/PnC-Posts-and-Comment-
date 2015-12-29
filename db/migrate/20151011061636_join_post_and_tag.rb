class JoinPostAndTag < ActiveRecord::Migration
  def change
	create_table :posts_tags do |a|
	a.integer :tag_id
	a.integer :post_id
	end
  end
end
