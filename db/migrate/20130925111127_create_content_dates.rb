class CreateContentDates < ActiveRecord::Migration
  def change
    create_table :content_dates do |t|
      t.date          :value
      t.timestamps
    end
  end
end
