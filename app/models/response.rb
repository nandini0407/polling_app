class Response < ActiveRecord::Base

  validates :user_id, :answer_id, presence: true
  validate :not_duplicate_response
  validate :not_own_poll

  belongs_to :respondent,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    primary_key: :id,
    foreign_key: :answer_id

  has_one :question,
    through: :answer_choice,
    source: :question

  has_one :poll,
    through: :question,
    source: :poll

  def not_duplicate_response
    user = self.respondent

    ques_id = self.question.id

    unless user.questions.where('questions.id = ?', ques_id).empty?
      errors[:user_id] << "already answered this poll"
    end
  end

  def not_own_poll
    user = self.respondent

    poll_id = self.question.poll_id

    unless user.authored_polls.where('polls.id = ?', poll_id).empty?
      errors[:user_id] << "cannot answer their own poll"
    end

  end


end
