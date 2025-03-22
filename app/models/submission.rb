class Submission < ApplicationRecord
  belongs_to :user

  def updated_at_ago
    time_ago_in_words(updated_at)
  end
end
