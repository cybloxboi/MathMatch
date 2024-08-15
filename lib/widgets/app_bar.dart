import 'package:flutter/material.dart';

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
                return const SingleChildScrollView(
                  child: Center(
                    child: SafeArea(
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
                              '1. เลือกว่าต้องการคำนวณหาค.ร.น. หรือ ห.ร.ม.\n2. กรอกตัวเลข ไม่เกินหลักหมื่น ตั้งแต่ 2 จำนวนขึ้นไป\nแต่ไม่เกิน 10 จำนวน\n3. กดปุ่ม "คำนวณหาค่า"',
                            ),
                            SizedBox(height: 35),
                            Divider(),
                            SizedBox(height: 35),
                            Text(
                                'แอพนี้จัดทำขึ้นโดยนักเรียนม.4/11 โรงเรียนอำนาจเจริญ'),
                            Text('ใช้สำหรับโครงงานคณิตศาสตร์'),
                            SizedBox(height: 35),
                            Divider(),
                            SizedBox(height: 35),
                            Text(
                              'รายชื่อผู้จัดทำ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              '1. นายศุกลณัฏฐ์ ถาวรฟัง ชั้นม.4/11 เลขที่ 27\n2. นายวชิรวิทย์ สมณา ชั้นม.4/11 เลขที่ 4\n3. นายกิตติวัฒน์ ขจัดมลทิน ชั้นม.4/11 เลขที่ 11',
                            ),
                            SizedBox(height: 35),
                            Divider(),
                            SizedBox(height: 35),
                            Text('ขอบคุณที่ใช้งานแอพของเรา ^~^'),
                            SizedBox(height: 15),
                            Text('หากเกิดข้อผิดพลาดประการใด'),
                            Text(
                                'ขอน้อมรับปรับปรุง แก้ไข และขออภัย ณ ที่นี่ด้วย'),
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
