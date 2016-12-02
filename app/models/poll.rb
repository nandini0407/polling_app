class Poll < ActiveRecord::Base

  validates :author_id, :title, presence: true
  
  has_many :questions,
    class_name: "Question",
    primary_key: :id,
    foreign_key: :poll_id

  belongs_to :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :author_id

end
