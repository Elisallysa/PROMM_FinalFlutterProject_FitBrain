// Datos de los juegos de cálculo. Estos datos se verán en la lista extensible
// de juegos de cálculo.

List<Map<String, dynamic>> getMathgames() {
  List<Map<String, dynamic>> juegos = [];

  var juego1 = {
    'id': 1,
    'title': 'Da el cambio',
    'description':
        'Este juego pone a prueba tus habilidades de cálculo. Debes dar el cambio correcto a tu cliente.',
    'isExpanded': false
  };

  var juego2 = {
    'id': 2,
    'title': 'Cálculo a contrarreloj',
    'description':
        '¿Te gusta el cálculo mental? Este juego a contrarreloj te pondrá a prueba.',
    'isExpanded': false
  };

  juegos.insert(0, juego1);
  juegos.insert(1, juego2);

  return juegos;
}
