enum Calculate { gcd, lcm }

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

// ห.ร.ม.
int findGCD(List<int> numbers) {
  Map<int, List<int>> factorsMap = factorizeNumbers(numbers);
  List<int> commonFactors = findCommonFactors(factorsMap);

  // เอาเฉพาะลำดับที่ 2 (Index = 1) ไม่เอาเลข 1 ที่อยู่ (Index = 0)
  if (commonFactors.length == 1) {
    return commonFactors[0];
  } else {
    return commonFactors[1];
  }
}
