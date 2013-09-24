class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.text 		       :name
      t.text           :slug
      t.text 		       :help
      t.integer        :sort
      t.boolean        :hide
      t.references     :data_type
      t.references     :collection
      t.references     :validation
      t.timestamps
    end
  end
end
