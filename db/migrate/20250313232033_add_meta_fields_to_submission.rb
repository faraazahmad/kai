class AddMetaFieldsToSubmission < ActiveRecord::Migration[8.0]
  def change
    add_column :submissions, :summary, :text
    add_column :submissions, :metadata, :json
  end
end
