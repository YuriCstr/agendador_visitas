import 'package:agendador_visitas/src/helpers/database.dart';
import 'package:agendador_visitas/src/model/cliente.dart';
import 'package:agendador_visitas/src/ui/widgets/snackbar_widget.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClienteController extends GetxController {
  final GlobalKey<FormState> clientFormKey = GlobalKey<FormState>();
  final ctrlCodigo = TextEditingController();
  final ctrlNome = TextEditingController();
  final ctrlCpfCnpj = TextEditingController();
  final ctrlLogradouro = TextEditingController();
  final ctrlNumero = TextEditingController();
  final ctrlCEP = MaskedTextController(mask: '00000-000');
  final ctrlCidade = TextEditingController();
  final ctrlEstado = TextEditingController();
  final ctrlTelefone = TextEditingController();
  final clientList = <Cliente>[].obs;

  RxBool loading = false.obs;

  void checkFormAddAddress(BuildContext context) async {
    var formOk = clientFormKey.currentState!.validate();
    if (!formOk) {
      loading.value = false;
      return;
    } else {
      loading.value = true;
      DatabaseHelper.instance.addCliente(Cliente(
          codigo: int.parse(ctrlCodigo.text),
          nome: ctrlNome.text,
          cpfCnpj: int.parse(ctrlCpfCnpj.text),
          logradouro: ctrlLogradouro.text,
          numero: ctrlNumero.text,
          cep: int.parse(ctrlCEP.text.replaceAll("-", "")),
          cidade: ctrlCidade.text,
          uf: ctrlEstado.text,
          telefone: int.parse(ctrlTelefone.text),
          isSelect: false));
      Get.back();
      DatabaseHelper.instance.getClientes();
      loading.value = false;
      showSnackBar("Sucesso", "Sucesso ao criar um cliente", Colors.green);
    }
  }

  void clearController() {
    ctrlCodigo.text = "";
    ctrlNome.text = "";
    ctrlCpfCnpj.text = "";
    ctrlLogradouro.text = "";
    ctrlNumero.text = "";
    ctrlNumero.text = "";
    ctrlCEP.text = "";
    ctrlCidade.text = "";
    ctrlEstado.text = "";
    ctrlTelefone.text = "";
  }
}
