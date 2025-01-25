class CreateSubmissionTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :submission_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
