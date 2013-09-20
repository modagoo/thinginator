class CreateContentFiles < ActiveRecord::Migration
  def change
    create_table :content_files do |t|
      t.attachment  :value
      t.string      :value_fingerprint
      t.string      :value_content_type
      t.string      :value_file_size
      t.string      :value_file_name
      t.timestamps
    end
  end
end
