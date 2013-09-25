class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.text        :name
      t.text        :slug
      t.text        :introduction
      t.references  :user
      t.timestamps
    end
  end
end
