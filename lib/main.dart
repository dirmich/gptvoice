import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gptvoice/pallet.dart';
import 'package:gptvoice/routes/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GPT Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: Pallet.White,
          appBarTheme: const AppBarTheme(backgroundColor: Pallet.White)),
      getPages: RouteTable.routes,
      initialRoute: Routes.HOME,
    );
  }
}
