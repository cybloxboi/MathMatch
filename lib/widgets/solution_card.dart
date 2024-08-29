import 'package:flutter/material.dart';
import 'package:math_match/model/calculate.dart';

Widget solutionCard(bool isGCD, List<int> numbers) {
  if (isGCD) {
    Map<int, List<int>> factors = factorizeNumbers(numbers);
    List<int> commonFactors = findCommonFactors(factors);
    int gcd = findGCD(numbers);

    return _solutionCard([
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
          return factorsChips(
            numbers,
            index,
            commonFactors,
            factors,
            gcd,
          );
        },
      ),
      const SizedBox(height: 32),
      Text(
          'ตัวประกอบร่วมของ ${listToString(numbers)} คือ ${listToString(commonFactors)}'),
      const SizedBox(height: 8),
      Text(
        'ดังนั้น ห.ร.ม. ของ ${listToString(numbers)} คือ ${formatter.format(gcd)}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  } else {
    int lcmResult = lcmMultiple(numbers);
    Map<int, List<int>> factorsMap = listOfFactors(numbers, lcmResult);
    List<int> commonFactors = findCommonFactors(factorsMap);

    return _solutionCard([
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
          return factorsChips(
            numbers,
            index,
            commonFactors,
            factorsMap,
            lcmResult,
          );
        },
      ),
      const SizedBox(height: 32),
      Text(
          'ตัวคูณร่วมของ ${listToString(numbers)} คือ ${listToString(commonFactors)}'),
      const SizedBox(height: 8),
      Text(
        'ดังนั้น ค.ร.น. ของ ${listToString(numbers)} คือ ${formatter.format(lcmResult)}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  }
}

Widget _solutionCard(List<Widget> children) {
  return Card(
    child: ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 350,
        maxWidth: 500,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: children,
          ),
        ),
      ),
    ),
  );
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

Column factorsChips(
  List<int> numbers,
  int index,
  List<int> commonFactors,
  Map<int, List<int>> factors,
  int result,
) {
  return Column(
    children: [
      ListTile(
        title: Text('ตัวประกอบของ ${formatter.format(numbers[index])} คือ'),
      ),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: factors[numbers[index]]!.map((e) {
          Color? backgroundColor;

          if (e == result) {
            backgroundColor = Colors.lightBlueAccent;
          } else if (commonFactors.contains(e)) {
            backgroundColor = Colors.lightGreenAccent;
          }

          return Chip(
            label: Text(
              formatter.format(e),
              style: TextStyle(color: e == result ? Colors.white : null),
            ),
            backgroundColor: backgroundColor,
          );
        }).toList(),
      ),
    ],
  );
}
