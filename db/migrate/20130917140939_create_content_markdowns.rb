class CreateContentMarkdowns < ActiveRecord::Migration
  def change
    create_table :content_markdowns do |t|
      t.text :value
      t.timestamps
    end
  end
end
