class AddTypeToSubmission < ActiveRecord::Migration[8.0]
  def change
    add_column :submissions, :submission_type, :string
  end
end
