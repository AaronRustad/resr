require "spec_helper"

RSpec.describe Resr do
  it "has a version number" do
    expect(Resr::VERSION).not_to be nil
  end

  #describe '.list' do
    #subject { Resr.list }

    #it 'returns a the server reservations.' do
      #expect(subject).to_not be_nil
    #end
  #end

  #describe '.take' do
    #subject { Resr.take('server') }

    #it 'assumes ownership of a server' do
      #expect(subject).to eq 'OK'
    #end
  #end

  #describe '.free' do
    #subject { Resr.free('server') }

    #it 'disowns a server' do
      #expect(subject).to eq 'OK'
    #end
  #end
end
