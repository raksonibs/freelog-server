module Api
  module V1
    class AttendancesController < Api::V1::BaseController
      before_action :doorkeeper_authorize!, except: [:create, :index, :show, :me, :upload]
      before_action :find_attendance, only: [:show, :update, :destroy]
      
      def index
        render json: Attendance.all
      end

      def create
        attendance = Attendance.create(attendance_params)

        if attendance.save          
          render json: attendance, status: :ok
        else
          render json: ErrorSerializer.serialize(attendance.errors), status: :unprocessable_entity
        end
      end

      def show
         render json: @attendance
      end

      def update
        @attendance.assign_attributes(attendance_params)
        if @attendance.save
          render json: @attendance, status: :ok
        else
          render json: ErrorSerializer.serialize(@attendance.errors), status: :unprocessable_entity
        end
      end

      private
      def attendance_params
        params.require(:data).require(:attributes).permit()
      end

      def find_attendance
        @attendance = Attendance.find_by_id(params[:id])
      end      
    end
  end
end
