module Api
  module V1
    class ProjectsController < Api::V1::BaseController
      before_action :doorkeeper_authorize!, except: [:create, :index, :show, :me, :upload]
      before_action :find_project, only: [:show, :update, :destroy]
      
      def index
        render json: Project.all
      end

      def create
        project = current_user.projects.create(project_params)

        if project.save          
          render json: project, status: :ok
        else
          render json: ErrorSerializer.serialize(project.errors), status: :unprocessable_entity
        end
      end

      def show
         render json: @project
      end

      def update
        @project.assign_attributes(project_params)
        if @project.save
          render json: @project, status: :ok
        else
          render json: ErrorSerializer.serialize(@project.errors), status: :unprocessable_entity
        end
      end

      private
      def project_params
        params.require(:data).require(:attributes).permit()
      end

      def find_project
        @project = current_user.projects.find_by_id(params[:id])
      end      
    end
  end
end
