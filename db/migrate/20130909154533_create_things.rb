class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.references     :collection, null: false
      t.references     :user#, null: false
      t.timestamps
    end
  end
end
