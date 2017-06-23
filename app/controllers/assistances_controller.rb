class AssistancesController < ApplicationController
  before_action :authenticate_teacher!
  before_action :set_assistance, only: [:change_assist]

  # GET /teachers
  # GET /teachers.json
  def index
    @assistance = Assistance.all
  end

  def change_assist
    if @assistance.attend == true
      @assistance.attend = false
    else
      @assistance.attend = true
    end
    @assistance.save
    aux = {attend: @assistance.attend, id: @assistance.id}
    render json: aux.as_json
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.

  def assistance_params
    params.require(:assitance).permit(:date, :student, :email, :rut, :course)
  end

  def set_assistance
    @assistance = Assistance.find(params[:id])
  end
end
