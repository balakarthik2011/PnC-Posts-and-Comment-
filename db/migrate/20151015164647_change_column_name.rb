class ChangeColumnName < ActiveRecord::Migration
  def change
	rename_column :posts, :Name, :name
	rename_column :posts, :Email, :email
  end
end
