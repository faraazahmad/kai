class CreateHighlights < ActiveRecord::Migration[8.0]
  def change
    create_table :highlights do |t|
      t.string :text
      t.references :submission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
