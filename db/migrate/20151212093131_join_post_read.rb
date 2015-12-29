class JoinPostRead < ActiveRecord::Migration
  def change
    create_table :posts_users_read_status do |a|
      a.integer :user_id
      a.integer :post_id
    end
  end
end
