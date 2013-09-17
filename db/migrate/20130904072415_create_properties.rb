class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string 		     :name
      t.string         :slug
      t.text 		       :help
      t.references     :data_type
      t.references     :collection
      t.references     :validation
      t.timestamps
    end
  end
end
