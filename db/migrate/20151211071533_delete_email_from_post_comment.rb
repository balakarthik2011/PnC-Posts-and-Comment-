class DeleteEmailFromPostComment < ActiveRecord::Migration
  def change
    remove_column :posts ,:email
  end
end
