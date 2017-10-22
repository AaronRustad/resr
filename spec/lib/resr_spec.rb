require "spec_helper"

RSpec.describe Resr do
  it "has a version number" do
    expect(Resr::VERSION).not_to be nil
  end

  describe '.config' do
    context 'when environment variable is provided' do
      after { ENV.delete('RESR_CONFIG') }

      context 'with an unknown file' do
        it 'raises an exception' do
          ENV['RESR_CONFIG'] = '/tmp/not_found_file.yml'
          expect { Resr.config }.to raise_error(StandardError, 'Resr config not found at /tmp/not_found_file.yml')
        end
      end

      context 'with an known file' do
        it 'raises an exception' do
          ENV['RESR_CONFIG'] = './config/resr.yml'
          expect(Resr.config).to eq({"slack_token"=>"", "channels"=>{"dev-deploy-io"=>{"io"=>":flag-io:", "cat"=>":cat2:", "dog"=>":trashdog:"}, "dev-deploys"=>{"prod"=>":cat2:", "canary"=>":canary:"}}})
        end
      end
    end
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
