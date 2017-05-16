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
                            date: Time.parse(params[:date]),
                            attend: true).first_or_create(student_id: Student.where(rut: params[:rut]).first.id,
                                                               date: Time.parse(params[:date]),
                                                               attend: true)
    render json: aux
  end

  def destroy_assistance
    aux = Assistance.where(student_id: Student.where(rut: params[:rut]).first.id,
                           date: Time.parse(params[:date]),
                           attend: true).all
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



end

