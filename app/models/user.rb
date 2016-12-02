class User < ActiveRecord::Base

  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "Poll"

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Response"

  has_many :answers,
    through: :responses,
    source: :answer_choice

  has_many :questions,
    through: :answers,
    source: :question

  has_many :answered_polls,
    through: :questions,
    source: :poll
end
