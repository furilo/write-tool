class CreateAiUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :ai_units do |t|
      t.string :name
      t.references :prompt_project_version, null: false, foreign_key: true
      t.json :prompt
      t.json :llm_params
      t.timestamps
    end
  end
end
