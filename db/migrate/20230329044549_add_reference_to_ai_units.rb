class AddReferenceToAiUnits < ActiveRecord::Migration[7.0]
  def change
    add_reference :prompt_project_versions, :selected_ai_unit, foreign_key: {to_table: :ai_units}
  end
end
