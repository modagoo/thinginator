class CreateClassifications < ActiveRecord::Migration
  def change
    create_table :classifications do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
