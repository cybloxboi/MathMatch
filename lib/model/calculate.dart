enum Calculate { gcd, lcm }

// ห.ร.ม.
// แยกตัวประกอบ
Map<int, List<int>> factorizeNumbers(List<int> numbers) {
  Map<int, List<int>> factorsMap = {};

  for (int number in numbers) {
    List<int> factors = [];

    for (int i = 1; i <= number; i++) {
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
