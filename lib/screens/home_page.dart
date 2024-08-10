import 'package:flutter/material.dart';
import 'package:math_match/model/calculate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String appTitle = 'MathMatch';
  final double sizeBetween = 15;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Calculate _value = Calculate.gcd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.appTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                spacing: 20.0,
                children: [
                  choiceChip('ค.ร.น.', Calculate.gcd),
                  choiceChip('ห.ร.ม.', Calculate.lcm),
                ],
              ),
              SizedBox(height: widget.sizeBetween),
              Text(
                'กรอกตัวเลขที่ต้องการหา ${_value == Calculate.gcd ? 'ค.ร.น.' : 'ห.ร.ม.'}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: widget.sizeBetween),
              SizedBox(
                width: 350,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'ตัวเลข',
                    isDense: true,
                  ),
                  autofocus: true,
                  keyboardType: const TextInputType.numberWithOptions(),
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
              SizedBox(height: widget.sizeBetween),
              const Card(
                child: SizedBox(
                  width: 350,
                  height: 100,
                  child: Center(
                    child: Text('จำนวนตัวเลขที่กรอกจะปรากฎที่นี่ :)'),
                  ),
                ),
              ),
              SizedBox(height: widget.sizeBetween),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'คำนวณหาค่า',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ChoiceChip choiceChip(String text, Calculate value) {
    return ChoiceChip(
      label: Text(text),
      selected: _value == value,
      onSelected: (bool selected) {
        setState(() {
          _value = value;
        });
      },
    );
  }
}
