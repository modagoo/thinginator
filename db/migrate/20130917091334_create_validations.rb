class CreateValidations < ActiveRecord::Migration
  def change
    create_table :validations do |t|
      t.references  :validation_type
      t.references  :property
      t.string      :value
      t.timestamps
    end
  end
end
