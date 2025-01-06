class Player < ApplicationRecord
  has_many :player_matches
  has_many :matches, through: :player_matches

  def submit_answers(match, answers)
    results = []
    # Erstelle eine Hash-Map der Fragen mit den angepassten IDs
    adjusted_questions = match.questions.each_with_index.map { |q, index| [index + 1, q] }.to_h
    answers.each do |answer|
      question = adjusted_questions[answer[:question_id]]
      next unless question

      correct = question.correct_answer == answer[:answer]
      increment!(:score) if correct

      results << { question_id: answer[:question_id], correct: correct, correct_answer: question.correct_answer }
    end
    results
  end
end