class CreatePromptProjectVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :prompt_project_versions do |t|
      t.integer :version, null: false, default: 1
      t.references :prompt_project, null: false, foreign_key: true
      t.integer :executions_count, default: 0
      t.bigint :variables_sets_ids, array: true, default: []

      t.timestamps
    end

    add_index :prompt_project_versions, :version
  end
end
