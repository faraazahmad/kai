class AddNameToSubmission < ActiveRecord::Migration[8.0]
  def change
    add_column :submissions, :name, :string
  end
end
