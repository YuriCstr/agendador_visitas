class Tag {
  int? id;
  String? nome;

  Tag({
    this.id,
    this.nome,
  });

  factory Tag.fromMap(Map<String, dynamic> json) => Tag(
        id: json["id"],
        nome: json["nome"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "nome": nome,
      };
}
