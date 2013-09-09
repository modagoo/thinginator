class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.references    :thing
      t.references    :property
      t.references    :contentable, polymorphic: true
      t.timestamps
    end
  end
end
