# frozen_string_literal: true

class AuthenticationProofsController < ApplicationController
  before_action :find_user

  def create
    proof = AuthenticationProof.new authentication_proof_params
    proof.user = @user
    if proof.save
      proof.reload
      render json: { authentication_proof: proof }, status: :created
    else
      render json: { errors: proof.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find_by!(id: params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: 'User not found' }, status: :not_found
  end

  def authentication_proof_params
    params.require(:authentication_proof).permit(:time, :authenticated)
  end
end
