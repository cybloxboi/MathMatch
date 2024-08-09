import 'package:flutter/material.dart';

void main() => runApp(const MathMatch());

class MathMatch extends StatelessWidget {
  const MathMatch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MathMatch',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text('คำนวณค.ร.น.'),
        ],
      ),
    );
  }
}
