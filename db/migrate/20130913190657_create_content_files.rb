class CreateContentFiles < ActiveRecord::Migration
  def change
    create_table :content_files do |t|
      t.attachment  :value
      t.timestamps
    end
  end
end
