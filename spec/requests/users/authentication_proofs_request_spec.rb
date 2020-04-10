# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::AuthenticationProofs', type: :request do
  subject do
    post "/users/#{user.id}/authentication_proofs", params: params, as: :json
  end

  before { subject }

  let!(:user) { create(:user) }
  let(:params) { { time: time, authenticated: authenticated } }
  let(:time) { DateTime.now.iso8601 }
  let(:authenticated) { true }

  context 'when proof data is correct' do
    it 'creates the resource' do
      expect(response).to have_http_status(:created)
    end

    it 'returns the proof with the correct time' do
      response_hash = JSON.parse(response.body)
      expect(DateTime.parse(response_hash['authentication_proof']['time']).iso8601).to eq(time)
    end

    it 'returns the proof with the correct authenticated value' do
      response_hash = JSON.parse(response.body)
      expect(response_hash['authentication_proof']['authenticated']).to eq(authenticated)
    end
  end

  context 'when proof data is incorrect' do
    let(:time) { nil }

    it 'marks the resource as unprocessable' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "when user doesn't exist" do
    subject { post '/users/0/authentication_proofs', params: params, as: :json }

    it 'returns a not found' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
