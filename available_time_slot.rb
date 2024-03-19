require 'json'
require 'time'
require 'date'

def parse_json_file(file_path)
  json_data = File.read(file_path)
  JSON.parse(json_data)
rescue Errno::ENOENT
  puts "Le fichier #{file_path} est introuvable."
  nil
rescue JSON::ParserError
  puts "Le fichier #{file_path} n'est pas un fichier JSON valide."
  nil
end

def find_available_slots(serialized_agenda, duration)
  available_slots = []
  start_time = serialized_agenda.first['start'].to_date

  until start_time == serialized_agenda.last['end'].to_date.next
    daily_agenda = serialized_agenda.select do |event|
      start_date = event['start'].to_date
      start_date == start_time
    end
    available_slots.concat(find_slots_for_day(daily_agenda, start_time, duration))
    start_time = start_time.next
  end
  available_slots
end

def find_slots_for_day(events, start_time, duration)
  available_slots = []
  start_of_day = DateTime.new(start_time.year, start_time.month, start_time.day, 9, 0, 0)
  end_of_day = DateTime.new(start_time.year, start_time.month, start_time.day, 18, 0, 0)
  previous_event_end = start_of_day

  events.each do |event|
    start_time = event['start']
    end_time = event['end']

    if start_time > previous_event_end
      available_duration = (start_time - previous_event_end) * 24 * 60
      available_slots << [previous_event_end, start_time] if available_duration >= duration
    end
    previous_event_end = [previous_event_end, end_time].max
  end

  if end_of_day > previous_event_end
    available_duration = (end_of_day - previous_event_end) * 24 * 60
    available_slots << [previous_event_end, end_of_day] if available_duration >= duration
  end

  available_slots
end

def serialize_data(agenda1, agenda2)
  agenda1 = parse_json_file(agenda1)
  agenda2 = parse_json_file(agenda2)
  serialized_agenda1 = serialize_agenda(agenda1)
  serialized_agenda2 = serialize_agenda(agenda2)
  (serialized_agenda1 + serialized_agenda2).sort_by { |event| event['start'] }
end

def serialize_agenda(agenda)
  agenda.map do |event|
    event.each_with_object({}) do |(key, value), serialized_event|
      serialized_event[key] = DateTime.parse(value)
    end
  end
end

agenda1_path = 'input_andy.json'
agenda2_path = 'input_sandra.json'
serialize_agenda = serialize_data(agenda1_path, agenda2_path)

if serialize_agenda
  available_slots = find_available_slots(serialize_agenda, 60) # Durée de 1 heure
  available_slots.each do |slot|
    puts "#{slot[0].strftime('%Y-%m-%d %H:%M')} - #{slot[1].strftime('%Y-%m-%d %H:%M')}"
  end
else
  puts "Erreur lors de l'ouverture ou de l'analyse des fichiers JSON."
end
