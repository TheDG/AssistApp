# API Controler that serves all content
module Api
  class ContentController < Api::ApiController
    before_action :authenticate_teacher!

    def course_students
      @json = Course.where(teacher_id: current_teacher.id).all
      # TODO: check esto
      @aux = @json.as_json(include: :students)
      render json: @aux
    end

    def record_assistance
      # puts current_teacher
      # puts Student.where(rut: params[:rut]).first
      # puts Time.parse(params[:date])
      send_time = Time.parse(params[:date])
      time = Time.new(params[send_time.year, send_time.mon, send_time.mday, 5)
      aux = Assistance.where(student_id: Student.where(rut: params[:rut]).first.id,
                             date: time, attend: true).first
      unless aux
        aux = Assistance.where(student_id: Student.where(rut: params[:rut]).first.id,
                               date: time, course_id: params[:course_id],
                               attend: false).first
        if aux
          aux.attend = true
          aux.save
        else
          aux = Assistance.create(student_id: Student.where(rut: params[:rut]).first.id,
                          date: time, attend: true, course_id: params[:course_id])
          aux.save
        end
      end
      render json: aux
    end

    def destroy_assistance
      date = DateTime.parse(params[:date])
      aux = Assistance.where(student_id: Student.where(rut: params[:rut]).first.id,
                             attend: true).all
      aux = aux.where('date BETWEEN ? AND ?', date.beginning_of_day,
                      date.end_of_day)
      if aux
        aux.map(&:destroy)
        render json: {
          'success': true
        }
      else
        render json: {
          'success': false
        }
      end
    end

    # Not tested
    def daily_course_assistance
      course = Course.find(params[:id])
      date = DateTime.parse(params[:date])
      aux = course.assistances.where('date BETWEEN ? AND ?', date.beginning_of_day,
                                     date.end_of_day)
      aux = aux.where(course_id: params[:id]).as_json(include: :student)
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

    def destroy_all_assistance
      aux = Assistance.all
      if aux
        aux.map(&:destroy)
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
end
