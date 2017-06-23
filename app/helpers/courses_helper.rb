module CoursesHelper
  def last_attendence
    course_aux = nil
    last_assist = Date.new(2010, 1, 1)
    current_teacher.courses.each do |course|
      course.assistances.each do |assist|
        course_aux = course if assist.date > last_assist
      end
    end
    course_aux
  end

  def find_assit(date, student_id, course_id)
    aux = Assistance.where(date: date, student_id: student_id, course_id: course_id).first
    unless aux
      aux = Assistance.create(date: date, student_id: student_id, course_id: course_id, attend: false)
      puts date
    end
    aux.id
  end
end


