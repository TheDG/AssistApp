module TeachersHelper

  def student_number
    aux = 0
    current_teacher.courses.each do |course|
      aux += course.students.count
    end
    aux
  end
end
