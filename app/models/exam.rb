class Exam < ActiveRecord::Base
    has_many :student_exams
    has_many :students, through: :student_exams

    def insert_feedback(student, grade, comment)
        new_student_exam = StudentExam.create(exam_id: self.id, student_id: student.id, grade: grade, teacher_comment: comment)
        new_student_exam
    end

    def class_average
        self.student_exams.average(:grade)
    end

    def num_students
        self.students.count
    end

    def self.used_exams
        self.all.select do |exam_instance|
            exam_instance.num_students > 0
        end
    end
    
    def self.lowest_average
        average_sorted = self.used_exams.sort do |exam_instance_a, exam_instance_b|
            exam_instance_a.class_average <=> exam_instance_b.class_average
        end
        average_sorted.first
    end

    def self.drop_lowest_average
        lowest_id = self.lowest_average.id
        self.find(lowest_id).student_exams.destroy_all
        self.find(lowest_id).destroy
    end

end
