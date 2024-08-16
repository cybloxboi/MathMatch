import 'package:flutter/material.dart';
import 'package:math_match/main.dart';
import 'package:math_match/model/calculate.dart';

Widget solutionCard(bool isGCD, List<int> numbers) {
  if (isGCD) {
    Map<int, List<int>> factors = factorizeNumbers(numbers);
    List<int> commonFactors = findCommonFactors(factors);
    int gcd = findGCD(numbers);

    return Column(
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
                          subtitle:
                              Text(listToString(factors[numbers[index]]!)),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                        'ตัวประกอบร่วมของ ${listToString(numbers)} คือ ${listToString(commonFactors)}'),
                    const SizedBox(height: 8),
                    Text(
                      'ดังนั้น ห.ร.ม. ของ ${listToString(numbers)} คือ ${formatter.format(gcd)}',
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
      ],
    );
  } else {
    int lcmResult = lcmMultiple(numbers);
    Map<int, List<int>> factorsMap = listOfFactors(numbers, lcmResult);
    List<int> commonFactors = findCommonFactors(factorsMap);

    return Card(
      child: SizedBox(
        width: 350,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'แก้ปัญหาโดยการหาตัวคูณร่วม',
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
                    title: Text('ตัวคูณของ ${numbers[index]} คือ'),
                    subtitle: Text(
                        '${factorsMap[numbers[index]]!.first != numbers[index] ? '...' : ''}${listToString(factorsMap[numbers[index]]!)}...'),
                  );
                },
              ),
              const SizedBox(height: 8),
              Text(
                  'ตัวคูณร่วมของ ${listToString(numbers)} คือ ${listToString(commonFactors)}'),
              const SizedBox(height: 8),
              Text(
                'ดังนั้น ค.ร.น. ของ ${listToString(numbers)} คือ ${formatter.format(lcmResult)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String listToString(List<int> numbers) {
  String text = '';

  for (int number in numbers) {
    text += formatter.format(number);

    if (numbers.length > 1) {
      if (number == numbers[numbers.length - 2]) {
        text += ' และ ';
      } else if (number != numbers.last) {
        text += ', ';
      }
    }
  }

  return text;
}
