class AddStatusToSubmission < ActiveRecord::Migration[8.0]
  def change
    add_column :submissions, :status, :string
  end
end
