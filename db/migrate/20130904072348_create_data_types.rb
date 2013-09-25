      class CreateDataTypes < ActiveRecord::Migration
  def change
    create_table :data_types do |t|
      t.text 		       :friendly_name
      t.text 		       :name
      t.text           :help
      t.references      :user
      t.timestamps
    end
  end
end
