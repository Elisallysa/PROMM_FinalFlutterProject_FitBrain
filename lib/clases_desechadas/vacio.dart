import 'dart:convert';
import 'dart:io';

void main() async {
  Map<String, dynamic> newGanador = {
    'player': 'Player',
    'date': DateTime.now().toIso8601String(),
  };

  File file = File('./database/ganadores.json');

  if (!file.existsSync()) {
    file.createSync();
    file.writeAsStringSync(json.encode({
      'ganadores': [newGanador]
    }));
  } else {
    String jsonString = await file.readAsString();
    Map<String, dynamic> data = json.decode(jsonString);

    // Inicializar la lista de ganadores si no existe

    data['ganadores'].add(newGanador);

    String newJsonString = json.encode(data);
    file.writeAsStringSync(newJsonString);
  }
}
