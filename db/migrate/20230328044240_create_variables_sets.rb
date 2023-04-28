class CreateVariablesSets < ActiveRecord::Migration[7.0]
  def change
    create_table :variables_sets do |t|
      t.string :name
      t.json :variables
      t.belongs_to :user
      t.timestamps
    end
  end
end
