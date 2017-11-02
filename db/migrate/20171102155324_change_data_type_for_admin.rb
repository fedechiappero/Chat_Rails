class ChangeDataTypeForAdmin < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :role, :admin
    change_column :users, :admin, :boolean, default: false
  end
end
