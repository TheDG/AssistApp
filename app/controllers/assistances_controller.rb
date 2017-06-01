class AssistancesController < ApplicationController
  before_action :authenticate_teacher!

  # GET /teachers
  # GET /teachers.json
  def index
    @assistance = Assistance.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.

  def assistance_params
    params.require(:assitance).permit(:date, :student, :email, :rut, :course)
  end
end
