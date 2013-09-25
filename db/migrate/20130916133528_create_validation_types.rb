class CreateValidationTypes < ActiveRecord::Migration
  def change
    create_table :validation_types do |t|
      t.string         :friendly_name
      t.string         :name
      t.text           :help
      t.boolean        :requires_value
      t.references     :user
      t.timestamps
    end
  end
end
