class CreateDataLists < ActiveRecord::Migration
  def change
    create_table :data_lists do |t|
      t.references  :list
      t.references  :property
      t.boolean     :multiple
      t.timestamps
    end
  end
end
