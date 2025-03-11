class CreateSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :submissions do |t|
      t.string :title
      t.string :url
      t.references :user, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
