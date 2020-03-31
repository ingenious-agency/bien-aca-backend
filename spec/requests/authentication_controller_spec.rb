# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  context 'when authenticating' do
    before { post '/auth/login', params: params, as: :json }

    let!(:user) { create(:user, password: user_password, password_confirmation: user_password) }
    let(:params) { { email: user.email, password: login_password } }
    let(:user_password) { 'password' }
    let(:login_password) { 'password' }

    context 'when sending correct data' do
      it 'returns the ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a token' do
        response_hash = JSON.parse(response.body)
        expect(response_hash).to have_key('token')
      end

      it 'returns the exp' do
        response_hash = JSON.parse(response.body)
        expect(response_hash).to have_key('exp')
      end

      it 'returns the email' do
        response_hash = JSON.parse(response.body)
        expect(response_hash).to have_key('email')
      end
    end

    context 'when sending incorrect data' do
      let(:login_password) { 'passwordd' }

      it "doesn't log the user" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
