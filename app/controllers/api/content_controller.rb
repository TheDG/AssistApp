class Api::ContentController < Api::ApiController
  before_action :authenticate_teacher!

  def course_students
    @json = Course.where(teacher_id: 1).all
    aux = @json.as_json(:include => :students)
    render json: aux
  end

  def record_assistance
    #puts current_teacher
    #puts Student.where(rut: params[:rut]).first
    #puts Time.parse(params[:date])
    aux = Assistance.create(student_id: Student.where(rut: params[:rut]).first.id,
                            date: Time.parse(params[:date]),
                            attend: true)
    render json: aux
  end



end

