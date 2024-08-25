import 'package:flutter/material.dart';
import 'package:math_match/model/calculate.dart';
import 'package:math_match/widgets/app_bar.dart';
import 'package:math_match/widgets/solution_card.dart';
import 'package:tex_text/tex_text.dart';

import '../main.dart';

class ProofPage extends StatelessWidget {
  const ProofPage({
    super.key,
    required this.appTitle,
    required this.numbers,
    required this.sizeBetween,
    required this.boxConstraints,
    required this.numbersWidget,
  });

  final String appTitle;
  final List<int> numbers;
  final double sizeBetween;
  final BoxConstraints boxConstraints;
  final Iterable<Widget> numbersWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTitle(context, 'พิสูจน์ผลคำนวณ'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    'ตัวเลขที่คุณกรอก',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: sizeBetween),
                  Card(
                    child: ConstrainedBox(
                      constraints: boxConstraints,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: numbers.map((int number) {
                              return Chip(
                                label: Text(formatter.format(number)),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: sizeBetween),
                  const Divider(),
                  SizedBox(height: sizeBetween),
                  Builder(builder: (context) {
                    if (numbers.length > 2) {
                      return ManyNumsSolution(
                          sizeBetween: sizeBetween, numbers: numbers);
                    } else {
                      return Column(
                        children: [
                          const Text(
                            'การพิสูจน์ย้อนกลับของผลลัพธ์ตัวคูณร่วมน้อย (ค.ร.น. หรือ LCM) และ หารร่วมมาก (ห.ร.ม. หรือ GCD) สามารถทำได้โดยการใช้ความสัมพันธ์ระหว่าง ค.ร.น. และ ห.ร.ม. ของสองจำนวน ซึ่งความสัมพันธ์นี้คือ :',
                          ),
                          SizedBox(height: sizeBetween),
                          const TexText(
                              r'$LCM(a, b) = \frac{a \times b}{GCD(a, b)}$'),
                          SizedBox(height: sizeBetween),
                          const Divider(),
                          SizedBox(height: sizeBetween),
                          const Text(
                            'ขั้นตอนการพิสูจน์ย้อนกลับ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: sizeBetween),
                          const Text(
                            '1. คำนวณ ห.ร.ม. (GCD):',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text('จากผลลัพธ์ของการหา ห.ร.ม. ได้ดังนี้'),
                          SizedBox(height: sizeBetween),
                          solutionCard(true, numbers),
                          SizedBox(height: sizeBetween),
                          const Text(
                            '2. คำนวณ ค.ร.น. (LCM):',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text('จากผลลัพธ์ของการหา ค.ร.น. ได้ดังนี้'),
                          SizedBox(height: sizeBetween),
                          solutionCard(false, numbers),
                          SizedBox(height: sizeBetween),
                          const Text(
                              'จากสมการความสัมพันธ์ระหว่าง ค.ร.น. และ ห.ร.ม. คือ'),
                          SizedBox(height: sizeBetween),
                          const TexText(
                              r'$LCM(a, b) = \frac{a \times b}{GCD(a, b)}$'),
                          SizedBox(height: sizeBetween),
                          const Text('สามารถแปลงใหม่ได้เป็น'),
                          SizedBox(height: sizeBetween),
                          const TexText(
                              r'$LCM(a, b) \times GCD(a, b) = a \times b$'),
                          SizedBox(height: sizeBetween),
                          const Text('แทนค่าในสมการได้เป็น'),
                          SizedBox(height: sizeBetween),
                          TexText('${lcmMultiple(numbers)}'
                              r' $\times$ '
                              '${findGCD(numbers)}'
                              r' $=$ '
                              '${numbers[0]}'
                              r' $\times$ '
                              '${numbers[1]}'),
                          TexText('${lcmMultiple(numbers) * findGCD(numbers)}'
                              r' $=$ '
                              '${numbers[0] * numbers[1]}'),
                          SizedBox(height: sizeBetween),
                          const Text(
                            'ดังนั้น ผลลัพธ์นี้จึงถูกต้อง',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                  SizedBox(height: sizeBetween),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ManyNumsSolution extends StatelessWidget {
  const ManyNumsSolution({
    super.key,
    required this.sizeBetween,
    required this.numbers,
  });

  final double sizeBetween;
  final List<int> numbers;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [],
    );
  }
}
