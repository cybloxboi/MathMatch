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

List<List<int>> iep(List<int> numbers) {
  int n = numbers.length;
  List<List<int>> factors = [];
  List<List<int>> factors2 = [];
  List<List<int>> factors3 = [];

  factors3.add([]);

  int index = 0;

  for (int i = 1; i < n; i++) {
    for (int j = i + 1; j <= n; j++) {
      factors.add([numbers[i - 1]]);
      factors[index].add(numbers[j - 1]);
      index++;
    }
  }

  index = 0;

  if (n >= 4) {
    for (int i = 1; i < n; i++) {
      for (int j = i + 1; j <= n; j++) {
        for (int k = j + 1; k <= n; k++) {
          factors2.add([numbers[i - 1]]);
          factors2[index].add(numbers[j - 1]);
          factors2[index].add(numbers[k - 1]);
          index++;
        }
      }
    }
  }

  for (int i = 1; i <= n; i++) {
    factors3[0].add(numbers[i - 1]);
  }

  return factors + factors2 + factors3;
}

List<int> proofGCD(List<List<int>> iep) {
  List<int> frac = [];

  for (List<int> numbers in iep) {
    frac.add(findGCD(numbers));
  }

  return frac;
}
