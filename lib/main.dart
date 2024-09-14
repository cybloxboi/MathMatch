import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_match/screens/home_page.dart';

void main() => runApp(const MathMatch());

class MathMatch extends StatelessWidget {
  const MathMatch({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'MathMatch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        textTheme: GoogleFonts.sarabunTextTheme(textTheme),
      ),
      home: const HomePage(),
    );
  }
}
