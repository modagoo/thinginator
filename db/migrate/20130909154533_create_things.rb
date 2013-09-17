class CreateThings < ActiveRecord::Migration
  def change
    create_table :things do |t|
      t.references     :collection
      t.references     :user
      t.timestamps
    end
  end
end
