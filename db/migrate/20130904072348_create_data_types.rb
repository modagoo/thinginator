      class CreateDataTypes < ActiveRecord::Migration
  def change
    create_table :data_types do |t|
      t.string 		     :friendly_name
      t.string 		     :name
      t.text           :help
      t.timestamps
    end
  end
end
