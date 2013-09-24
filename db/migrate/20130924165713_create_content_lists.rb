class CreateContentLists < ActiveRecord::Migration
  def change
    create_table :content_lists do |t|
      t.text        :value
      t.timestamps
    end
  end
end
