# frozen_string_literal: true

require '/home/grant/RubymineProjects/RedCanary/spec/spec_helper.rb'

RSpec.describe 'Commands' do
  let(:file) { './testing.txt' }

  describe 'create_file' do
    subject { Command.create_file(file:) }

    before do
      allow(File).to receive(:open).and_call_original
    end

    after do
      File.delete(file)
    end

    it 'creates a file' do
      expect(File).to receive(:open).with(file, "w+").and_call_original
      expect(Logging).to receive(:log_file).and_call_original

      subject
    end
  end

  describe 'modify_file' do
    subject { Command.modify_file(file:) }

    before do
      File.open(file, 'w+')
      allow(File).to receive(:open).and_call_original
    end

    after do
      File.delete(file)
    end

    it 'appends to the file' do
      expect(File).to receive(:open).with(file, "w+").and_call_original do |test_file|
        expect(test_file).to receive(:write)
      end
      expect(Logging).to receive(:log_file).and_call_original

      subject
    end
  end

  describe 'delete_file' do
    subject { Command.delete_file(file:) }

    context 'when the file exists' do
      before do
        File.open(file, 'w+')
        allow(File).to receive(:open).and_call_original
      end


      it 'deletes the file' do
        expect(File).to receive(:delete).with(file).and_call_original
        expect(Logging).to receive(:log_file).and_call_original

        subject
      end
    end

    context 'when the file does not exist' do
      it 'does not delete the file' do
        expect(File).to_not receive(:delete)
        subject
      end
    end

  end

  describe 'send_data' do
    subject { Command.send_data(address:, body:) }

    let(:address) { "https://google.com" }
    let(:body) { {'testing': 'testing'} }

    before do
      stub_request(:post, "https://google.com/").
        with(
          body: "{:testing=>\"testing\"}",
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host'=>'google.com',
            'User-Agent'=>'Ruby'
          }).
        to_return(status: 200, body: "stubbed", headers: {})
    end

    it 'sends the data' do
      expect(Logging).to receive(:log_network).and_call_original
      expect(subject).to eq("stubbed")

    end
  end

  describe 'run_process' do
    subject { Command.run_process(cmd:, args:) }

    let(:cmd) { "echo abc" }
    let(:args) { [] }

    it 'runs the process' do
      expect(Logging).to receive(:log_process).and_call_original

      expect(subject[0]).to eq("abc\n")
    end
  end
end
