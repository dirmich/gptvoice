// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:gptvoice/home/controller.dart';
import 'package:gptvoice/home/openai_service.dart';
import 'package:gptvoice/home/view.dart';

class Routes {
  static const HOME = '/home';
  static const CHAT = '/chat';
}

class RouteTable {
  static final routes = [
    GetPage(
        name: Routes.HOME,
        page: () => const HomeView(),
        binding: BindingsBuilder(() {
          Get.put<OpenAIService>(OpenAIService());
          Get.lazyPut<HomeController>(() => HomeController());
        })),
  ];
}
