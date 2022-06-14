import 'package:agendador_visitas/src/controller/cliente_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NovoClienteForm extends StatelessWidget {
  NovoClienteForm({Key? key}) : super(key: key);
  final controller = Get.put(ClienteController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text("Adicionar um novo cliente"),
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            children: [
              Form(
                key: controller.clientFormKey,
                child: Expanded(
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .2,
                            child: buildFormField(controller.ctrlCodigo,
                                "Código", TextInputType.number, 10),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .7,
                            child: buildFormField(controller.ctrlNome,
                                "Nome do cliente", TextInputType.name, 200),
                          ),
                        ],
                      ),
                      buildFormField(controller.ctrlCpfCnpj, "CPF/CNPJ",
                          TextInputType.number, 14),
                      buildFormField(controller.ctrlLogradouro, "Logradouro",
                          TextInputType.name, 200),
                      buildFormField(controller.ctrlNumero,
                          "Número da residencia", TextInputType.name, 20),
                      buildFormField(
                          controller.ctrlCEP, "CEP", TextInputType.number, 9),
                      buildFormField(controller.ctrlCidade, "Cidade",
                          TextInputType.name, 100),
                      buildFormField(
                          controller.ctrlEstado, "UF", TextInputType.name, 50),
                      buildFormField(controller.ctrlTelefone, "Telefone",
                          TextInputType.number, 12),
                      InkWell(
                        onTap: () {
                          controller.checkFormAddAddress(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(
                              color: (Colors.green),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: 50,
                          width: 220,
                          alignment: Alignment.center,
                          child: Text(
                            "Adicionar cliente",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

buildFormField(TextEditingController controller, String hint,
    TextInputType inputType, int limite) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      maxLines: 1,
      controller: controller,
      keyboardType: inputType,
      validator: (value) => value!.isEmpty ? "Preencha o campo $hint" : null,
      inputFormatters: [
        LengthLimitingTextInputFormatter(limite),
      ],
      decoration: InputDecoration(
        hintMaxLines: 5,
        hintText: hint,
        contentPadding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green),
        ),
      ),
    ),
  );
}
