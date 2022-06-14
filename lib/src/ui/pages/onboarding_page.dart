import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView.builder(
        itemCount: 1,
        itemBuilder: (_, i) {
          return Stack(
            children: [
              Image.asset(
                "assets/onboard.png",
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height - 24,
                width: MediaQuery.of(context).size.width,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          width: 210,
                          child: Text(
                            "Agendamento rápido, prático e simples",
                            style: TextStyle(
                                fontSize: 32, color: Color(0xFFCBCBD4)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            "A melhor maneira de gerenciar suas rotas e agendamentos.",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFFCBCBD4)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      buildIndex(i),
                      InkWell(
                        onTap: () => Get.offAndToNamed('/home'),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFFAF795D)),
                          child: const Center(
                            child: Text(
                              "Começar agora",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    ));
  }

  buildIndex(int index) {
    int currentIndex = 0;
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          3,
          (index) => Container(
            margin: const EdgeInsets.only(right: 5),
            height: 5,
            width: currentIndex == index ? 27 : 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: currentIndex == index
                  ? const Color(0xFFAF795D)
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
