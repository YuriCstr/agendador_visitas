import 'package:agendador_visitas/src/routes/app_routes.dart';
import 'package:agendador_visitas/src/ui/pages/detalhes_rota_page.dart';
import 'package:agendador_visitas/src/ui/pages/forms/nova_rota_form.dart';
import 'package:agendador_visitas/src/ui/pages/forms/novo_cliente_form.dart';
import 'package:agendador_visitas/src/ui/pages/home_page.dart';
import 'package:agendador_visitas/src/ui/pages/onboarding_page.dart';
import 'package:agendador_visitas/src/ui/pages/rota_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.initial,
      page: () => OnBoardingPage(),
    ),
    GetPage(
      name: Routes.home,
      page: () => HomePage(),
      transition: Transition.fade,
    ),
    GetPage(
      name: Routes.novo_cliente,
      page: () => NovoClienteForm(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.nova_rota,
      page: () => NovaRotaForm(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.rota_detalhes,
      page: () => DetalhesRotaPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: Routes.cliente_page,
      page: () => RotaPage(),
      transition: Transition.fade,
    ),
  ];
}
