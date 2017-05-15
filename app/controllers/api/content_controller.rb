class Api::ContentController < Api::ApiController
  before_action :authenticate_teacher!

  def course_students
    @json = Course.where(teacher_id: 1).all
    aux = @json.as_json(:include => :students)
    render json: aux
  end
end

