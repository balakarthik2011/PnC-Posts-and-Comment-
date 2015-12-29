class RenamePost < ActiveRecord::Migration
  def change
    rename_column :ratings, :post, :post_id
  end
end
