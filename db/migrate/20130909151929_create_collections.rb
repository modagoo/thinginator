class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.text        :name
      t.text        :slug
      t.text        :introduction
      t.references  :user, null: false
      t.timestamps
    end
  end
end
