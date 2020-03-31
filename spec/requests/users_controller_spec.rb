# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'when creating users' do
    def create_user
      post '/users', params: { user: params }, as: :json
    end

    subject { create_user }

    before { subject }

    let(:params) do
      { name: name, email: email, password: password,
        password_confirmation: password_confirmation, identity_number: identity_number,
        date_of_birth: date_of_birth, gender: gender,
        cellphone: cellphone, lat: lat, lng: lng }
    end
    let(:name) { Faker::Name.name }
    let(:email) { Faker::Internet.email }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }
    let(:identity_number) { Faker::IDNumber.valid }
    let(:date_of_birth) { 35.years.ago }
    let(:gender) { User.genders[:male] }
    let(:cellphone) { Faker::PhoneNumber.cell_phone }
    let(:lat) { -34.147275 }
    let(:lng) { -54.517891 }

    context 'when sending correct data' do
      it 'creates the user' do
        expect(response).to have_http_status(:success)
      end
    end

    context "when password doesn't match" do
      let(:password_confirmation) { 'passwordd' }

      it "doesn't creates the user" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when sending incorrect data' do
      let(:cellphone) { nil }

      it "doesn't creates the user" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
