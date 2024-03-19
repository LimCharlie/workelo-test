require 'rspec'
require_relative '../available_time_slot'

RSpec.describe '.find_available_slots' do
  subject { find_available_slots(serialized_data, duration) }
  let(:andy_file) { File.expand_path('../input_andy.json', __dir__) }
  let(:sandra_file) { File.expand_path('../input_sandra.json', __dir__) }
  let(:files) { [andy_file, sandra_file] }
  let(:duration) { 60 }
  let(:serialize_data) { serialize_data(andy_file, sandra_file) }

  it 'should finds available slots for both agendas' do
    expected_output = [
      ['2022-08-01 14:00', '2022-08-01 15:00'],
      ['2022-08-02 17:00', '2022-08-02 18:00'],
      ['2022-08-04 15:00', '2022-08-04 16:00'],
      ['2022-08-04 17:00', '2022-08-04 18:00']
    ]
    actual_output = @available_slots.map { |slot| slot.map { |dt| dt.strftime('%Y-%m-%d %H:%M') } }
    expect(subject).to match_array(expected_output)
  end
end
