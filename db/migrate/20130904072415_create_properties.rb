class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.string :slug
      t.references :record_type
      t.timestamps
    end
  end
end
