class CreatePromptProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :prompt_projects do |t|
      t.string :title
      t.text :description
      t.integer :visibility, index: true, default: 0
      t.string :slug, index: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
