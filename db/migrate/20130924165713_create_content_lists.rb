class CreateContentLists < ActiveRecord::Migration
  def change
    create_table :content_lists do |t|

      t.timestamps
    end
  end
end
