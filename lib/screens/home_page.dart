import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_match/model/calculate.dart';
import 'package:math_match/widgets/app_bar.dart';
import 'package:math_match/widgets/solution_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String appTitle = 'MathMatch';
  final double sizeBetween = 25;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late Calculate _value;
  late List<int> numbers;
  late TextEditingController controller;
  late bool _solutionVisible;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _solutionVisible = false;
    numbers = [];
    _value = Calculate.lcm;
    numbers = [];
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarTitle(context, widget.appTitle),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                // ปุ่มเลือกหาค.ร.น. หรือห.ร.ม.
                Wrap(
                  spacing: 20.0,
                  children: [
                    choiceChip('ค.ร.น.', Calculate.lcm),
                    choiceChip('ห.ร.ม.', Calculate.gcd),
                  ],
                ),
                SizedBox(height: widget.sizeBetween),
                // แบบฟอร์ม
                Text(
                  'กรอกตัวเลขที่ต้องการหา ${_value == Calculate.lcm ? 'ค.ร.น.' : 'ห.ร.ม.'}',
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
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'ตัวเลข',
                              isDense: true,
                            ),
                            validator: (value) {
                              if (numbers.length == 10) {
                                return 'จำนวนตัวเลข ครบ 10 จำนวนแล้ว';
                              }

                              if (value == null || value.isEmpty) {
                                return 'กรุณาเติมตัวเลข';
                              }

                              if (int.tryParse(value)! <= 0) {
                                return 'ไม่สามารถกรอกตัวเลข $value ได้';
                              }

                              if (value.length > 5) {
                                return 'ไม่สามารถกรอกจำนวนที่มากกว่าหลักหมื่นได้';
                              }

                              if (numbers.contains(int.tryParse(value))) {
                                return 'มีตัวเลขนี้อยู่แล้ว';
                              }

                              return null;
                            },
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            textInputAction: TextInputAction.done,
                            controller: controller,
                            onFieldSubmitted: (value) {
                              if (_formKey.currentState!.validate()) {
                                addNumbers(value);
                              }

                              if (_solutionVisible) {
                                setState(() {
                                  _solutionVisible = !_solutionVisible;
                                });
                              }
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 2,
                        child: OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addNumbers(controller.text);
                            }

                            if (_solutionVisible) {
                              setState(() {
                                _solutionVisible = !_solutionVisible;
                              });
                            }
                          },
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
                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          numbers.clear();
                                        });
                                      },
                                      child: const Text('ล้างทั้งหมด'),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    children: numbersWidget.toList(),
                                  ),
                                ],
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
                  onPressed: numbers.length < 2
                      ? null
                      : () {
                          if (!_solutionVisible) {
                            setState(() {
                              _solutionVisible = !_solutionVisible;
                            });
                          }
                        },
                  child: const Text(
                    'คำนวณหาค่า',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: widget.sizeBetween),
                AnimatedOpacity(
                  opacity: _solutionVisible ? 1 : 0,
                  duration: Durations.medium2,
                  child: numbers.isNotEmpty && _solutionVisible
                      ? solutionCard(_value == Calculate.gcd, numbers)
                      : const SizedBox.shrink(),
                ),
                SizedBox(height: widget.sizeBetween),
              ],
            ),
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

        if (_solutionVisible) {
          setState(() {
            _solutionVisible = !_solutionVisible;
          });
        }
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

          if (_solutionVisible) {
            _solutionVisible = !_solutionVisible;
          }
        },
        deleteButtonTooltipMessage: 'ลบตัวเลข',
      );
    });
  }

  void addNumbers(String value) {
    setState(() {
      numbers.add(int.parse(value));
      controller.clear();
    });
  }
}
