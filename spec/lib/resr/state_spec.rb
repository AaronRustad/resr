# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Resr::State do
  let(:name) { 'reservations' }
  let(:mappings) { { 'cat' => ':cat:', 'io' => ':flag-io:', 'cat2' => ':cat2:', 'bird' => ':bird:' } }
  let(:client) { double('SlackClient') }
  let(:state) { ':flag-io: user_1, :cat: user_2, :bird:, :cat2: user_4' }

  subject { Resr::State.new(name, mappings, client) }

  before do
    expect(subject).to receive(:channel_topic).and_return(state)
  end

  describe '#details' do
    it 'returns the current details of the servers' do
      expect(subject.details('io')).to eq 'user_1'
    end

    it 'returns nil when server has no details' do
      expect(subject.details('bird')).to eq nil
    end

    context 'when the server does not exist' do
      it 'raises an error' do
        expect { subject.details('xxxx') }.to raise_error(StandardError, 'No such server: xxxx')
      end
    end
  end
end
