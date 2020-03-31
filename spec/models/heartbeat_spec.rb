# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Heartbeat, type: :model do
  context 'when creating a user heartbeat' do
    it 'creates the heartbeat'

    context 'with missing time' do
      it "doesn't create the heartbeat"
      it 'populates the error message'
    end

    context 'with missing lat' do
      it "doesn't create the heartbeat"
      it 'populates the error message'
    end

    context 'with missing lng' do
      it "doesn't create the heartbeat"
      it 'populates the error message'
    end

    context 'with the location is inside the fence' do
      it 'correctly calculates the within fence value'
      it 'updates the user value'
    end

    context 'with the location is outside the fence' do
      it 'correctly calculates the within fence value'
      it 'updates the user value'
    end
  end
end
