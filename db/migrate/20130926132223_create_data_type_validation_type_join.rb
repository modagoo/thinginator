class CreateDataTypeValidationTypeJoin < ActiveRecord::Migration
  def change
    create_table :data_types_validation_types do |t|
      t.integer :data_type_id
      t.integer :validation_type_id
    end
  end
end
