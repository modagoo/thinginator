class CreateContentTexts < ActiveRecord::Migration
  def change
    create_table :content_texts do |t|
      t.text      :value
      t.timestamps
    end
  end
end
