class CreateContentTimes < ActiveRecord::Migration
  def change
    create_table :content_times do |t|
      t.time        :value
      t.timestamps
    end
  end
end
