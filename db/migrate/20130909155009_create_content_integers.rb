class CreateContentIntegers < ActiveRecord::Migration
  def change
    create_table :content_integers do |t|
      t.integer       :value
      t.timestamps
    end
  end
end
