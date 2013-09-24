class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :username
      t.text :firstname
      t.text :lastname
      t.boolean :admin, default: false
      t.boolean :superuser, default: false
      t.timestamps
    end
  end
end
