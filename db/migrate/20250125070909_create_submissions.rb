class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
      t.references :submission_type, null: false, foreign_key: true
      t.string :link

      t.timestamps
    end
  end
end
