class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.boolean :admin, default: false
      t.boolean :superuser, default: false
      t.timestamps
    end
  end
end
