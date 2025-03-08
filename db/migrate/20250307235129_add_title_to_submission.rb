class AddTitleToSubmission < ActiveRecord::Migration[8.0]
  def change
    add_column :submissions, :title, :string
  end
end
