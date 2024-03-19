require 'rspec'
require_relative '../available_time_slot'

RSpec.describe '.find_available_slots' do
  subject { find_available_slots(data, duration) }
  let(:andy_file) { File.expand_path('../input_andy.json', __dir__) }
  let(:sandra_file) { File.expand_path('../input_sandra.json', __dir__) }
  let(:duration) { 60 }
  let(:data) { serialized_data(andy_file, sandra_file) }

  context 'When everything is fine' do
    it 'should finds available slots for both agendas' do
      expected_output = [
        ['2022-08-01 14:00', '2022-08-01 15:00'],
        ['2022-08-02 17:00', '2022-08-02 18:00'],
        ['2022-08-04 15:00', '2022-08-04 16:00'],
        ['2022-08-04 17:00', '2022-08-04 18:00']
      ]

      expect(subject).to match_array(expected_output)
    end
  end
end
