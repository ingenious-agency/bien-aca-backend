# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Heartbeat, type: :model do
  context 'when creating a user heartbeat' do
    subject do
      described_class.create(attributes)
    end

    let(:user) { create(:user) }
    let(:attributes) { { time: time, lat: lat, lng: lng, user_id: user.id } }
    let(:time) { DateTime.now.iso8601 }
    let(:lat) { -34.894348 }
    let(:lng) { -56.152937 }

    it 'creates the heartbeat' do
      expect { subject }.to change(described_class, :count).by(1)
    end

    context 'with missing time' do
      let(:time) { nil }

      it "doesn't create the heartbeat" do
        expect { subject }.not_to change(described_class, :count)
      end

      it 'populates the error message' do
        expect(subject.errors).to have_key(:time)
      end
    end

    context 'with missing lat' do
      let(:lat) { nil }

      it "doesn't create the heartbeat" do
        expect { subject }.not_to change(described_class, :count)
      end

      it 'populates the error message' do
        expect(subject.errors).to have_key(:lat)
      end
    end

    context 'with missing lng' do
      let(:lng) { nil }

      it "doesn't create the heartbeat" do
        expect { subject }.not_to change(described_class, :count)
      end

      it 'populates the error message' do
        expect(subject.errors).to have_key(:lng)
      end
    end

    context 'with the location is inside the fence' do
      let(:user) { create(:user, lat: lat, lng: lng) }

      it 'correctly calculates the within fence value' do
        expect(subject.within_fence).to eq(true)
      end

      it 'updates the user value' do
        expect(subject.user.within_fence).to eq(true)
      end
    end

    context 'with the location is outside the fence' do
      let(:lat) { -36.894348 }
      let(:lng) { -57.152937 }
      let(:user) { create(:user) }

      it 'correctly calculates the within fence value' do
        expect(subject.within_fence).to eq(false)
      end

      it 'updates the user value' do
        expect(subject.user.within_fence).to eq(false)
      end
    end
  end
end
