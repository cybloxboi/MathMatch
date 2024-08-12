import 'package:flutter/material.dart';
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
  late List<int> numbers;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    numbers = [];
  }

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
                                '1. เลือกว่าต้องการหาค.ร.น. หรือ ห.ร.ม.\n2. กรอกตัวเลขตั้งแต่ 2 จำนวนขึ้นไป\n3. กดปุ่มคำนวณหาค่า',
                              ),
                              SizedBox(height: 35),
                              Divider(),
                              SizedBox(height: 50),
                              Text(
                                  'แอพนี้จัดทำขึ้นโดยนักเรียนม.4/11 โรงเรียนอำนาจเจริญ'),
                              Text('ใช้สำหรับโครงงานคณิตศาสตร์'),
                              SizedBox(
                                height: 15,
                              ),
                              Text('ขอบคุณที่ใช้แอพของเรา ^~^'),
                              SizedBox(height: 20)
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
              const Spacer(),
              Text(
                'กรอกตัวเลขที่ต้องการหา ${_value == Calculate.gcd ? 'ค.ร.น.' : 'ห.ร.ม.'}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: widget.sizeBetween),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 2,
                    child: OutlinedButton(
                      onPressed: () {
                        if (controller.text.isNotEmpty) {
                          numbers.add(int.parse(controller.text));
                          print('เพิ่มเลข ${controller.text} ลงใน List แล้ว');
                          print(numbers);
                          controller.clear();
                        }
                      },
                      child: const Text('เพิ่ม'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: widget.sizeBetween),
              // ---------------- กรณีไม่มีข้อมูล
              const Card(
                child: SizedBox(
                  width: 350,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('จำนวนตัวเลขที่กรอกจะปรากฎที่นี่ :)'),
                    ),
                  ),
                ),
              ),
              // ----------------------- กรณีมีข้อมูล
              // Card(
              //   child: SizedBox(
              //     width: 350,
              //     child: Center(
              //       child: Padding(
              //         padding: const EdgeInsets.all(16),
              //         child: Wrap(
              //           spacing: 8,
              //           children: [
              //             Chip(
              //               label: const Text('2'),
              //               onDeleted: () {},
              //             ),
              //             Chip(
              //               label: const Text('4'),
              //               onDeleted: () {},
              //             ),
              //             Chip(
              //               label: const Text('2'),
              //               onDeleted: () {},
              //             ),
              //             Chip(
              //               label: const Text('4'),
              //               onDeleted: () {},
              //             ),
              //             Chip(
              //               label: const Text('2'),
              //               onDeleted: () {},
              //             ),
              //             Chip(
              //               label: const Text('4'),
              //               onDeleted: () {},
              //             ),
              //             Chip(
              //               label: const Text('2'),
              //               onDeleted: () {},
              //             ),
              //             Chip(
              //               label: const Text('4'),
              //               onDeleted: () {},
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
              const Spacer(),
              const SizedBox(height: 100),
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
