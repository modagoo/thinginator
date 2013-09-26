class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.references    :user
      t.text          :controller
      t.text          :action
      t.text          :ip
      t.text          :message
      t.timestamps
    end
  end
end
