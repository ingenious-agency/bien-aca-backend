# frozen_string_literal: true

class HeartbeatsController < ApplicationController
  before_action :find_user

  def create
    heartbeat = Heartbeat.new heartbeat_params
    heartbeat.user = @user
    if heartbeat.save
      heartbeat.reload
      render json: { heartbeat: heartbeat }, status: :created
    else
      render json: { errors: heartbeat.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find_by!(id: params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def heartbeat_params
    params.require(:heartbeat).permit(:time, :lat, :lng, :data)
  end
end
