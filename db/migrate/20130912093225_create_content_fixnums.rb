class CreateContentFixnums < ActiveRecord::Migration
  def change
    create_table :content_fixnums do |t|
      t.integer   :value
      t.timestamps
    end
  end
end
