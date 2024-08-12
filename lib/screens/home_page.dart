import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_match/model/calculate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String appTitle = 'MathMatch';
  final double sizeBetween = 25;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Calculate _value = Calculate.gcd;
  List<int> numbers = [];
  TextEditingController controller = TextEditingController();

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
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 25),
                              Text(
                                'วิธีการใช้งาน',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                '1. เลือกว่าต้องการหาค.ร.น. หรือ ห.ร.ม.\n2. กรอกตัวเลขไม่เกินหลักหมื่นตั้งแต่ 2 จำนวนขึ้นไป\nแต่ไม่เกิน 10 จำนวน\n3. กดปุ่มคำนวณหาค่า',
                              ),
                              SizedBox(height: 35),
                              Divider(),
                              SizedBox(height: 35),
                              Text(
                                  'แอพนี้จัดทำขึ้นโดยนักเรียนม.4/11 โรงเรียนอำนาจเจริญ'),
                              Text('ใช้สำหรับโครงงานคณิตศาสตร์'),
                              SizedBox(
                                height: 15,
                              ),
                              Text('ขอบคุณที่ใช้แอพของเรา ^~^'),
                              SizedBox(height: 35)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.help),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Wrap(
                spacing: 20.0,
                children: [
                  choiceChip('ค.ร.น.', Calculate.gcd),
                  choiceChip('ห.ร.ม.', Calculate.lcm),
                ],
              ),
              const SizedBox(height: 20),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 3,
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
                        textInputAction: TextInputAction.done,
                        controller: controller,
                        onFieldSubmitted: addNumbers,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Flexible(
                      flex: 2,
                      child: OutlinedButton(
                        onPressed: () => addNumbers(controller.text),
                        child: const Text('เพิ่ม'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: widget.sizeBetween),
              Card(
                child: SizedBox(
                  width: 350,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Builder(
                        builder: (_) {
                          if (numbers.isEmpty) {
                            return const Text(
                                'จำนวนตัวเลขที่กรอกจะปรากฎที่นี่ :)');
                          } else {
                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: numbersWidget.toList(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: widget.sizeBetween),
              ElevatedButton(
                onPressed: numbers.length < 2 ? null : () {},
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

  Iterable<Widget> get numbersWidget {
    return numbers.map((int number) {
      return Chip(
        label: Text(
          number.toString(),
        ),
        onDeleted: () {
          setState(() {
            numbers.removeWhere((int entry) {
              return entry == number;
            });
          });
        },
      );
    });
  }

  void addNumbers(String value) {
    setState(() {
      if (value.isNotEmpty &&
          value.length <= 5 &&
          !numbers.contains(int.parse(value))) {
        numbers.add(int.parse(value));
        controller.clear();
      }
    });
  }
}
