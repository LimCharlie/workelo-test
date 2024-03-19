require_relative 'available_time_slot'

agenda1_path = 'input_andy.json'
agenda2_path = 'input_sandra.json'
serialize_agenda = serialized_data(agenda1_path, agenda2_path)

if serialize_agenda
  available_slots = find_available_slots(serialize_agenda, 60) # Durée de 1 heure
  available_slots.each do |slot|
    puts "#{slot[0]} - #{slot[1]}"
  end
else
  puts "Erreur lors de l'ouverture ou de l'analyse des fichiers JSON."
end
