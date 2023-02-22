// Datos de los juegos de lengua. Estos datos se verán en la lista extensible
// de juegos de lengua.

List<Map<String, dynamic>> getLanguageGames() {
  List<Map<String, dynamic>> juegos = [];

  var juego1 = {
    'id': 1,
    'title': 'Sinónimos',
    'description':
        'Nos encanta la homonimia y la polisemia. Hmm, ¿son sinónimos? Debes elegir la palabra con el mismo significado.',
    'isExpanded': false
  };

  var juego2 = {
    'id': 1,
    'title': '¿Qué significa?',
    'description':
        'Si no eres un diccionario andante, no estás invitado a la fiesta. Elige la definición correcta.',
    'isExpanded': false
  };

  var juego3 = {
    'id': 2,
    'title': 'Palabras en familia',
    'description':
        'Detecta al intruso. Hay una palabra que no pertenece a la familia semántica del resto. ¡Rápido, se acaba el tiempo!',
    'isExpanded': false
  };

  juegos.insert(0, juego1);
  juegos.insert(1, juego2);
  juegos.insert(2, juego3);

  return juegos;
}
