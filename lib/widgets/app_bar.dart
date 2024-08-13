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
  );
}
