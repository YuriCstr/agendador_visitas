import 'package:agendador_visitas/src/model/cliente.dart';

class Rota {
  int? id;
  String? nome;
  DateTime? dataPrevista;
  List<Cliente>? clientesDaRota;

  Rota({
    this.id,
    this.nome,
    this.dataPrevista,
    this.clientesDaRota,
  });

  factory Rota.fromMap(Map<String, dynamic> json) => Rota(
        id: json["id"],
        nome: json["nome"],
        dataPrevista: DateTime.parse(json["dataPrevista"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
        "dataPrevista": dataPrevista!.toIso8601String(),
      };
}
