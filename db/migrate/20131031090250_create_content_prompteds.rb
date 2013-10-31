class CreateContentPrompteds < ActiveRecord::Migration
  def change
    create_table :content_prompteds do |t|
      t.string        :value
      t.timestamps
    end
  end
end
