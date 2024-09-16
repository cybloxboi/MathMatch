import 'package:flutter/material.dart';
import 'package:math_match/model/calculate.dart';

class SolutionCard extends StatefulWidget {
  const SolutionCard({
    super.key,
    required this.isGcd,
    required this.numbers,
    required this.boxConstraints,
  });

  final bool isGcd;
  final List<int> numbers;
  final BoxConstraints boxConstraints;

  @override
  State<SolutionCard> createState() => _SolutionCardState();
}

class _SolutionCardState extends State<SolutionCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.isGcd) {
      Map<int, List<int>> factors = factorizeNumbers(widget.numbers);
      List<int> commonFactors = findCommonFactors(factors);
      int gcd = findGCD(widget.numbers);

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
          itemCount: widget.numbers.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return factorsChips(
              widget.numbers,
              index,
              commonFactors,
              factors,
              gcd,
              true,
              context,
            );
          },
        ),
        const SizedBox(height: 32),
        Text(
            'ตัวประกอบร่วมของ ${listToString(widget.numbers)} คือ ${listToString(commonFactors)}'),
        const SizedBox(height: 8),
        Text(
          'ดังนั้น ห.ร.ม. ของ ${listToString(widget.numbers)} คือ ${formatter.format(gcd)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ], widget.boxConstraints);
    } else {
      int lcmResult = lcmMultiple(widget.numbers);
      Map<int, List<int>> factorsMap = listOfFactors(widget.numbers, lcmResult);
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
          itemCount: widget.numbers.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return factorsChips(
              widget.numbers,
              index,
              commonFactors,
              factorsMap,
              lcmResult,
              false,
              context,
            );
          },
        ),
        const SizedBox(height: 32),
        Text(
            'ตัวคูณร่วมของ ${listToString(widget.numbers)} คือ ${listToString(commonFactors)}'),
        const SizedBox(height: 8),
        Text(
          'ดังนั้น ค.ร.น. ของ ${listToString(widget.numbers)} คือ ${formatter.format(lcmResult)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ], widget.boxConstraints);
    }
  }

  Widget _solutionCard(List<Widget> children, BoxConstraints boxConstraints) {
    return Card(
      child: ConstrainedBox(
        constraints: boxConstraints,
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
    bool isGcd,
    BuildContext context,
  ) {
    return Column(
      children: [
        ListTile(
          title: Text(
              '${isGcd ? 'ตัวประกอบ' : 'ตัวคูณร่วม'}ของ ${formatter.format(numbers[index])} คือ'),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: factors[numbers[index]]!.map((e) {
            Color primaryColor = Theme.of(context).colorScheme.primary;
            Color secondaryColor = Theme.of(context).colorScheme.secondary;

            Color? backgroundColor;

            if (e == result) {
              backgroundColor = primaryColor;
            } else if (commonFactors.contains(e)) {
              backgroundColor = secondaryColor;
            }

            return Chip(
              label: Text(
                formatter.format(e),
                style: TextStyle(
                    color: backgroundColor != null
                        ? Theme.of(context).colorScheme.onPrimary
                        : null),
              ),
              backgroundColor: backgroundColor ??
                  Theme.of(context).chipTheme.backgroundColor,
            );
          }).toList(),
        ),
      ],
    );
  }
}
