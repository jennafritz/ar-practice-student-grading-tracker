class StudentExam < ActiveRecord::Base
    belongs_to :student
    belongs_to :exam

    def print_details
        puts "#{self.student.name} took the #{self.exam.subject} exam receiving a score of #{self.grade}"
    end

    def questions_correct_ratio
        total_correct = ((self.grade*self.exam.total_questions)/100).round
        "#{total_correct} questions correct out of #{self.exam.total_questions} questions total"
    end
end