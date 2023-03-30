import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gptvoice/components/featureBox.dart';
import 'package:gptvoice/home/controller.dart';
import 'package:gptvoice/pallet.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.grey),
        child: Obx(() => Scaffold(
              appBar: AppBar(
                title: const Text('GPT Voice'),
                centerTitle: true,
                leading: const Icon(Icons.menu),
                actions: [
                  TextButton(
                      onPressed: () {
                        controller.toggleLanguage();
                        // controller.openai.imageApi('create a baby image');
                      },
                      child: Text(controller.isKorean.value ? '한국어' : 'Eng'))
                ],
              ),
              body: Column(
                children: [
                  Stack(children: [
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Pallet.GPTColor,
                        ),
                        // child: Image.asset(
                        //   'lib/assets/images/virtualAssistant.png',
                        // ),
                      ),
                    ),
                    Container(
                        height: 123,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              'lib/assets/images/virtualAssistant.png',
                            ),
                          ),
                        ))
                  ]),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40)
                        .copyWith(top: 30),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))
                                .copyWith(topLeft: Radius.zero),
                        border: Border.all(color: Pallet.BorderColor)),
                    child: Text(
                      'Good morning, what task can I do for you',
                      style: GoogleFonts.nanumGothic(
                          fontWeight: FontWeight.bold,
                          color: Pallet.mainFontColor,
                          fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 10, left: 22),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Herer are a few features',
                      style: GoogleFonts.nanumGothic(
                          color: Pallet.mainFontColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    children: const [
                      FeatureBox(
                          title: 'ChatGPT',
                          content:
                              'A smarter way to stay organized and informed with ChatGPT',
                          color: Pallet.BoxColor1),
                      FeatureBox(
                          title: 'Dall-E',
                          content:
                              'Get inspired and stay creative with your personal assistant powered by Dall-E',
                          color: Pallet.BoxColor2),
                      FeatureBox(
                          title: 'Voice Assistant',
                          content:
                              'Get the best of both worlds with a voice assistant powered',
                          color: Pallet.BoxColor3)
                    ],
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: !controller.isInitialized.value
                    ? Colors.grey
                    : controller.isListening.value
                        ? Colors.red
                        : Pallet.BoxColor1,
                onPressed: () async {
                  controller.isListening.value
                      ? await controller.stopListening()
                      : await controller.startListening();
                },
                child: const Icon(Icons.mic),
              ),
            )));
  }
}
