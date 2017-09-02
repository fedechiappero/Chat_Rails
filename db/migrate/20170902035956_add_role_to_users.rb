class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :string, default: 'USER' #tengo solo dos tipos de usuario asi que esto deberia ser booleano
    add_column :users, :active, :boolean, default: true
  end
end
