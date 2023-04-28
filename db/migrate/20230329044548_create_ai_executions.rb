class CreateAiExecutions < ActiveRecord::Migration[7.0]
  def change
    create_table :ai_executions do |t|
      t.references :prompt_project_version, null: false, foreign_key: true
      t.references :ai_unit, null: false, foreign_key: true
      t.references :variables_set, foreign_key: true
      t.json :response
      t.timestamps
    end
  end
end
