class Question < ActiveRecord::Base

  validates :poll_id, presence: true

  has_many :answer_choices,
    class_name: "AnswerChoice",
    primary_key: :id,
    foreign_key: :question_id

  belongs_to :poll,
    class_name: "Poll",
    primary_key: :id,
    foreign_key: :poll_id

  def results
    results = {}

    answers = self.answer_choices.includes(:responses)

    answers.each do |choice|
      results[choice] = choice.responses.length
    end

    results
  end

  def results_sql
    Question.find_by_sql([<<-SQL, self.id])
      SELECT
        COUNT(answer_choices.*) AS num_responses, answer_choices.text
      FROM
        answer_choices
      LEFT JOIN
        responses ON answer_choices.id = responses.answer_id
      WHERE
        answer_choices.question_id = ?
      GROUP BY
        answer_choices.id
    SQL

    # query.first.num_responses
  end

  def results_active_record
    self.answer_choices
      .select('answer_choices.*, COUNT(answer_choices.*) AS num_responses')
      .joins('LEFT JOIN responses ON answer_choices.id = responses.answer_id')
      .group('answer_choices.id')
  end

end
