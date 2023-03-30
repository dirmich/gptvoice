import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gptvoice/pallet.dart';

class FeatureBox extends StatelessWidget {
  final String title;
  final String content;
  final Color color;
  const FeatureBox(
      {super.key,
      required this.title,
      required this.content,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          title,
          style: GoogleFonts.nanumGothic(
              fontSize: 16, fontWeight: FontWeight.bold, color: Pallet.Black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          content,
          style: GoogleFonts.nanumGothic(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Pallet.mainFontColor),
        )
      ]),
    );
  }
}
