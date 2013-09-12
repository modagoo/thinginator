class CreateContentDatetimes < ActiveRecord::Migration
  def change
    create_table :content_datetimes do |t|
      t.datetime :value
      t.timestamps
    end
  end
end
