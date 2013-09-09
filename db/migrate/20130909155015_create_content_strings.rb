class CreateContentStrings < ActiveRecord::Migration
  def change
    create_table :content_strings do |t|
      t.string        :value
      t.timestamps
    end
  end
end
