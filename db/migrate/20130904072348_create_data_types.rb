      class CreateDataTypes < ActiveRecord::Migration
  def change
    create_table :data_types do |t|
      t.string 		     :name
      t.string 		     :slug
      t.timestamps
    end
  end
end
