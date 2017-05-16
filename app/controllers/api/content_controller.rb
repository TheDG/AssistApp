class Api::ContentController < Api::ApiController
  before_action :authenticate_teacher!

  def course_students
    #@json = Course.where(teacher_id: current_teacher.id).all
    @json = Course.where(teacher_id: 1).all
    aux = @json.as_json(:include => :students)
    render json: aux
  end

  def record_assistance
    #puts current_teacher
    #puts Student.where(rut: params[:rut]).first
    #puts Time.parse(params[:date])
    aux = Assistance.where(student_id: Student.where(rut: params[:rut]).first.id,
                           date: Time.parse(params[:date]), course_id: params[:course_id],
                           attend: true).first_or_create(student_id: Student.where(rut: params[:rut]).first.id,
                                                         date: Time.parse(params[:date]).to_date,
                                                          attend: true, course_id: params[:course_id] )
    render json: aux
  end

  def destroy_assistance
    date = DateTime.parse(params[:date])
    aux = Assistance.where(student_id: Student.where(rut: params[:rut]).first.id,
                           attend: true).all
    aux = aux.where('date BETWEEN ? AND ?', date.beginning_of_day,
                                   date.end_of_day)
    if aux
      aux.each do |assist|
        assist.destroy
      end
      render json: {
          'success': true
      }
    else
      render json: {
          'success': false
      }
    end
  end

  def daily_course_assistance
    course = Course.find(params[:id])
    #puts params[:date]
    #puts Assistance.first.date.to_date
    #assistance = Assistance.where(date: params[:date])
    date = DateTime.parse(params[:date])
    aux = course.assistances.where('date BETWEEN ? AND ?', date.beginning_of_day,
                                   date.end_of_day)
    aux = aux.where(course_id: params[:id])
    aux = aux.as_json(:include => :student)

    if aux
      render json: {
          'success': true,
          "course-#{params[:id]}-assistance": aux
      }
    else
      render json: {
          'success': false
      }
    end
  end



end

