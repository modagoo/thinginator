class CreateContentBooleans < ActiveRecord::Migration
  def change
    create_table :content_booleans do |t|
      t.boolean :value
      t.timestamps
    end
  end
end
