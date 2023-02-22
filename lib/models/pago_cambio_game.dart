import 'dart:convert';
// To parse this JSON data:
// final CambioPago = CambioPagoFromJson(jsonString);

// Método de serialización de string de json a lista de CambioPago
List<CambioPago> cambioPagoFromJson(String str) =>
    List<CambioPago>.from(json.decode(str).map((x) => CambioPago.fromJson(x)));

// Método de serialización de lista de CambioPago a cadena de caracteres
String cambioPagoToJson(List<CambioPago> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CambioPago {
  // Clase que contiene los datos de una posible ronda del juego Da el cambio.
  // Contiene un pago y un precio mínimo y máximo para pagar.
  CambioPago({
    required this.pago,
    required this.preciomax,
    required this.preciomin,
  });

  int pago;
  int preciomax;
  int preciomin;

  factory CambioPago.fromJson(Map<String, dynamic> json) => CambioPago(
        pago: json["pago"],
        preciomax: json["preciomax"],
        preciomin: json["preciomin"],
      );

  Map<String, dynamic> toJson() => {
        "pago": pago,
        "preciomax": preciomax,
        "preciomin": preciomin,
      };
}
