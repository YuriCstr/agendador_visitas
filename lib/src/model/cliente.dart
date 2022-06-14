List<Cliente> clienteFromMap(str) =>
    List<Cliente>.from(str.map((x) => Cliente.fromMap(x)));

class Cliente {
  int? id;
  int codigo;
  String nome;
  String cpfCnpj;
  String logradouro;
  String numero;
  int cep;
  String cidade;
  String uf;
  int telefone;
  int? status;
  bool isSelect;

  Cliente(
      {this.id,
      required this.codigo,
      required this.nome,
      required this.cpfCnpj,
      required this.logradouro,
      required this.numero,
      required this.cep,
      required this.cidade,
      required this.uf,
      required this.telefone,
      this.status,
      required this.isSelect});

  factory Cliente.fromMap(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        codigo: json["codigo"],
        nome: json["nome"],
        cpfCnpj: json["cpfCnpj"],
        logradouro: json["logradouro"],
        numero: json["numero"],
        cep: int.parse(json["cep"]),
        cidade: json["cidade"],
        uf: json["uf"],
        telefone: int.parse(json["telefone"]),
        status: json["status"],
        isSelect: json["isSelect"] == 1 ? true : false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "nome": nome,
        "cpfCnpj": cpfCnpj,
        "logradouro": logradouro,
        "numero": numero,
        "cep": cep,
        "cidade": cidade,
        "uf": uf,
        "telefone": telefone,
        "status": status,
        "isSelect": isSelect ? 1 : 0,
      };
}
