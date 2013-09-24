class CreateListValues < ActiveRecord::Migration
  def change
    create_table :list_values do |t|
      t.text        :value
      t.integer     :sort
      t.references  :list
      t.timestamps
    end
  end
end
