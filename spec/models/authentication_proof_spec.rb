# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationProof, type: :model do
  context 'when creating a user proof' do
    subject do
      described_class.create(attributes)
    end

    let(:user) { create(:user) }
    let(:attributes) { { time: time, authenticated: authenticated, user_id: user.id } }
    let(:time) { DateTime.now.iso8601 }
    let(:authenticated) { true }

    it 'creates the proof' do
      expect { subject }.to change(described_class, :count).by(1)
    end

    context 'with missing time' do
      let(:time) { nil }

      it "doesn't create the proof" do
        expect { subject }.not_to change(described_class, :count)
      end

      it 'populates the error message' do
        expect(subject.errors).to have_key(:time)
      end
    end

    context 'with missing authenticated' do
      let(:authenticated) { nil }

      it "doesn't create the proof" do
        expect { subject }.not_to change(described_class, :count)
      end

      it 'populates the error message' do
        expect(subject.errors).to have_key(:authenticated)
      end
    end

    context 'with the authenticated in true' do
      it 'updates the user value' do
        expect(subject.user.last_authentication).to eq(true)
      end
    end

    context 'with the authenticated in false' do
      let(:authenticated) { false }

      it 'updates the user value' do
        expect(subject.user.last_authentication).to eq(false)
      end
    end
  end
end
