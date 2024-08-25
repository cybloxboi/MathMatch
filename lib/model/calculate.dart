import 'package:intl/intl.dart';

enum Calculate { gcd, lcm }

NumberFormat formatter = NumberFormat.decimalPatternDigits();

// แยกตัวประกอบ
Map<int, List<int>> factorizeNumbers(List<int> numbers) {
  Map<int, List<int>> factorsMap = {};

  for (int number in numbers) {
    List<int> factors = [];

    for (int i = 1; i <= number; i++) {
      // หาตัวหารลงตัว
      if (number % i == 0) {
        factors.add(i);
      }
    }

    factorsMap[number] = factors;
  }

  return factorsMap;
}

// หาตัวประกอบร่วม
List<int> findCommonFactors(Map<int, List<int>> factorsMap) {
  // เริ่มด้วยตัวประกอบตัวแรก
  List<int> commonFactors = factorsMap.values.first;

  // หาจุดตัดของตัวประกอบแต่ละตัว
  for (List<int> factors in factorsMap.values) {
    commonFactors =
        commonFactors.where((factor) => factors.contains(factor)).toList();
  }

  return commonFactors;
}

// ค.ร.น.
int lcm(int a, int b) {
  int max = (a > b) ? a : b;
  int lcm = max;

  while (true) {
    if (lcm % a == 0 && lcm % b == 0) {
      return lcm;
    }

    lcm += max;
  }
}

int lcmMultiple(List<int> numbers) {
  if (numbers.isEmpty) return 0;

  int lcmResult = numbers[0];

  for (int i = 1; i < numbers.length; i++) {
    lcmResult = lcm(lcmResult, numbers[i]);
  }

  return lcmResult;
}

Map<int, List<int>> listOfFactors(List<int> numbers, int lcm) {
  Map<int, List<int>> factorsMap = {};

  for (int number in numbers) {
    List<int> factors = [];
    int multiply = 2;

    factors.add(number);

    while (number * multiply <= lcm || factors.length < 6) {
      if (factors.length > 6) {
        factors.removeAt(0);
      }

      factors.add(number * multiply);
      multiply++;
    }

    factorsMap[number] = factors;
  }

  return factorsMap;
}

// ห.ร.ม.
int findGCD(List<int> numbers) {
  Map<int, List<int>> factorsMap = factorizeNumbers(numbers);
  List<int> commonFactors = findCommonFactors(factorsMap);

  return commonFactors.last;
}
