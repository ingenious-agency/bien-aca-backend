# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Heartbeats', type: :request do
  subject { post "/users/#{user.id}/heartbeats", params: params, as: :json }

  before { subject }

  let!(:user) { create(:user) }
  let(:params) { { time: time, lat: lat, lng: lng } }
  let(:time) { DateTime.now.iso8601 }
  let(:lat) { -34.894348 }
  let(:lng) { -56.152937 }

  context 'when heartbeat data is correct' do
    it 'creates the resource' do
      expect(response).to have_http_status(:created)
    end

    it 'returns the heartbeat with the correct time' do
      response_hash = JSON.parse(response.body)
      expect(DateTime.parse(response_hash['heartbeat']['time']).iso8601).to eq(time)
    end

    it 'returns the heartbeat with the correct lat' do
      response_hash = JSON.parse(response.body)
      expect(response_hash['heartbeat']['lat']).to eq(lat.to_s)
    end

    it 'returns the heartbeat with the correct lng' do
      response_hash = JSON.parse(response.body)
      expect(response_hash['heartbeat']['lng']).to eq(lng.to_s)
    end
  end

  context 'when heartbeat data is incorrect' do
    let(:lng) { nil }

    it 'marks the resource as unprocessable' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context "when user doesn't exist" do
    subject { post '/users/0/heartbeats', params: params, as: :json }

    it 'returns a not found' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
