import 'package:agendador_visitas/src/model/cliente.dart';
import 'package:flutter/material.dart';

class ClientesWidget extends StatelessWidget {
  final Cliente cliente;
  const ClientesWidget({Key? key, required this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {
          _detalhesCliente(context, cliente);
        },
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cliente.nome,
                    style: TextStyle(fontSize: 18),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 2),
                cliente.cpfCnpj.toString().characters.length <= 12
                    ? Text("CPF: ${cliente.cpfCnpj}",
                        style: TextStyle(fontSize: 14))
                    : Text("CNPJ: ${cliente.cpfCnpj}",
                        style: TextStyle(fontSize: 14)),
                SizedBox(height: 2),
                Text("${cliente.telefone}", style: TextStyle(fontSize: 14)),
                SizedBox(height: 2),
                Text(
                    "${cliente.logradouro} nº ${cliente.numero} ${cliente.cep}",
                    style: TextStyle(fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
                SizedBox(height: 2),
                Text(cliente.cidade + ", " + cliente.uf,
                    style: TextStyle(fontSize: 14))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _detalhesCliente(BuildContext context, Cliente cliente) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () async {},
                        child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              "Editar",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: 40,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: Text(
                              "Excluir",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
