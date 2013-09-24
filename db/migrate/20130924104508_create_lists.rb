class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.text        :name
      t.text        :slug
      t.references  :user
      t.timestamps
    end
  end
end
