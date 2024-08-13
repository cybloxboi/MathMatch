import 'package:flutter/material.dart';
import 'package:math_match/model/calculate.dart';

Widget solutionCard(bool cardVisible, bool isAlreadyVisible, bool isGCD, List<int> numbers) {
  if (isGCD) {
    Map<int, List<int>> factors = factorizeNumbers(numbers);
    List<int> commonFactors = findCommonFactors(factors);
    int gcd = findGCD(numbers);

    return AnimatedOpacity(
      opacity: cardVisible ? 1 : 0,
      duration: isAlreadyVisible ? Duration.zero : Durations.medium2,
      child: Column(
        children: [
          Card(
            child: SizedBox(
              width: 350,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'แก้ปัญหาโดยการแยกตัวประกอบ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        itemCount: numbers.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('ตัวประกอบของ ${numbers[index]} คือ'),
                            subtitle: Text(factors[numbers[index]].toString()),
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      Text('ตัวประกอบร่วมของ $numbers คือ $commonFactors'),
                      const SizedBox(height: 8),
                      Text(
                        'ดังนั้น ห.ร.ม. ของ $numbers คือ $gcd',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  } else {
    return AnimatedOpacity(
      opacity: cardVisible ? 1 : 0,
      duration: isAlreadyVisible ? Duration.zero : Durations.medium2,
      child: const Card(
        child: SizedBox(
          width: 350,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text('ขี้เกียจคิดครับ อีป้า'),
          ),
        ),
      ),
    );
  }
}
