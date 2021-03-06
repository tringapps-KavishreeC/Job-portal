# frozen_string_literal: true

module Api
  module V1
    class JobsController < Api::ApplicationController
      before_action :set_job, only: %i[show update destroy]
      # before_action :has_applied?, only: [:new, :create]
      # GET /jobs
      def index
        @jobs = Job.all
        # @job_app = JobApplication.new(params)
      end

      # GET /jobs/1
      def show
        @job = Job.find(params[:id])
        # render json: @job
      end

      # POST /jobs
      def create
        @job = Job.new(job_params)

        if @job.save
          render json: @job, status: :created, location: @job
        else
          render json: @job.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /jobs/1
      def update
        if @job.update(job_params)
          render json: @job
        else
          render json: @job.errors, status: :unprocessable_entity
        end
      end

      # DELETE /jobs/1
      def destroy
        @job.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_job
        @job = Job.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def job_params
        params.require(:job).permit(:name, :desc, :position, :count)
      end
    end
  end
end
