require 'pry'

class Student < ActiveRecord::Base
    has_many :student_exams
    has_many :exams, through: :student_exams

    def self.upper_classmen
        self.all.select do |student_instance|
            student_instance.year >= 3
        end
    end

    def self.under_classmen
        self.all.select do |student_instance|
            student_instance.year <= 2
        end
    end

    def self.subject_matter_experts(degree)
        self.all.select do |student_instance|
            student_instance.degree == degree
        end
    end

    def num_exams
        self.exams.count
    end

    def self.exam_taker_professional
        exam_amount_sorted = self.all.sort do |student_instance_a, student_instance_b|
            student_instance_b.num_exams <=> student_instance_a.num_exams
        end
        binding.pry
        exam_amount_sorted.first
    end

    def overall_average
        self.student_exams.average(:grade).to_i
    end

    def self.rising_star
        average_sorted = self.all.sort do |student_instance_a, student_instance_b|
            # binding.pry
            student_instance_b.overall_average <=> student_instance_a.overall_average
        end
        average_sorted.first
    end

    def self.valedictorian
        seniors = self.all.sort do |student_instance|
            student_instance.year = 4
        end
        average_sorted_seniors = seniors.sort do |student_instance_a, student_instance_b|
            student_instance_b.overall_average <=> student_instance_a.overall_average
        end
        average_sorted_seniors.first
    end
end
