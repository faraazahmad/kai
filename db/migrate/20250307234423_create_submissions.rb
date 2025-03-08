class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end
