import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

PreferredSizeWidget appBarTitle(BuildContext context, String appTitle) {
  return AppBar(
    title: Text(
      appTitle,
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
                return SingleChildScrollView(
                  child: Center(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 25),
                            const Text(
                              'วิธีการใช้งาน',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              '1. เลือกว่าต้องการคำนวณหาค.ร.น. หรือ ห.ร.ม.\n2. กรอกตัวเลข ไม่เกินหลักหมื่น ตั้งแต่ 2 จำนวนขึ้นไป\nแต่ไม่เกิน 10 จำนวน\n3. กดปุ่ม "คำนวณหาค่า"',
                            ),
                            const SizedBox(height: 35),
                            const Divider(),
                            const SizedBox(height: 35),
                            const Text(
                                'แอพนี้จัดทำขึ้นโดยนักเรียนม.4/11 โรงเรียนอำนาจเจริญ'),
                            const Text('ใช้สำหรับโครงงานคณิตศาสตร์'),
                            const SizedBox(height: 35),
                            const Divider(),
                            const SizedBox(height: 35),
                            const Text(
                              'รายชื่อผู้จัดทำ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              '1. นายศุกลณัฏฐ์ ถาวรฟัง ชั้นม.4/11 เลขที่ 27\n2. นายวชิรวิทย์ สมณา ชั้นม.4/11 เลขที่ 4\n3. นายกิตติวัฒน์ ขจัดมลทิน ชั้นม.4/11 เลขที่ 11',
                            ),
                            const SizedBox(height: 35),
                            const Divider(),
                            const SizedBox(height: 35),
                            const Text('ขอบคุณที่ใช้งานแอพของเรา ^~^'),
                            const SizedBox(height: 15),
                            const Text('หากเกิดข้อผิดพลาดประการใด'),
                            const Text(
                                'ขอน้อมรับปรับปรุง แก้ไข และขออภัย ณ ที่นี่ด้วย'),
                            const SizedBox(height: 35),
                            const Divider(),
                            const SizedBox(height: 35),
                            const Text('เวอร์ชั่น v1.0.5'),
                            const SizedBox(height: 35),
                            GestureDetector(
                              onTap: () async {
                                const url =
                                    'https://github.com/cybloxboi/MathMatch';

                                if (await canLaunchUrlString(url)) {
                                  await launchUrlString(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.link),
                                  SizedBox(width: 5),
                                  Text(
                                    'GitHub',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 35),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.help),
          tooltip: 'วิธีการใช้งาน และเครดิต',
        ),
      ),
    ],
  );
}
