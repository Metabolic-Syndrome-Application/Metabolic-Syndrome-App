import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/widget/onboarding/OnboardingDesc.dart';

import '../../widget/onboarding/NextOnboardingButton.dart';

void main() {
  runApp(HealthPlan());
}

class HealthPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "first page onbroading",
      home: HealthPlanPage(),
    );
  }
}

class HealthPlanPage extends StatefulWidget {
  @override
  State<HealthPlanPage> createState() => _HealthPlanPageState();
}

class _HealthPlanPageState extends State<HealthPlanPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                children: [
                  OnboardingDesc(
                    "แผนสุขภาพ\nเฉพาะบุคคล",
                    "วิเคราะห์ความเสี่ยงเเละติดตามผลสุขภาพในเเบบของคุณ\nรวมถึงเเนะนำขั้นตอนการปรับเปลี่ยนพฤติกรรม\nที่เกิดจากภาวะเมตาบอลิกซินโดรม",
                    "ถัดไป",
                    Color(hexColor('#6D81E9')),
                    'assets/images/healthNotePage.png'
                  ),
                  OnboardingDesc(
                    "บันทึกประจำวัน",
                    "สามารถจดบันทึกค่าสุขภาพในเเต่ละวันได้\nพร้อมทั้งติดตามเเนวโน้มสุขภาพของคุณ\nรวมถึงการเเจ้งเตือนสำคัญต่างๆ ที่ต้องทำ",
                    "ถัดไป",
                    Color(hexColor('#42884B')),
                    'assets/images/healthPlanPage.png'
                  ),
                  OnboardingDesc(
                      "ความรู้เเละความท้าทาย",
                      "ช่วยให้ความรู้เเละความเข้าใจเกี่ยวกับภาวะ\nเมตาบอลิกซินโดรม เเถมยังเพลิดเพลินกับกิจกรรม\nความท้าทายภายในเเอปพลิเคชัน",
                      "เริ่มใช้งานกันเลย !",
                      Color(hexColor('#F94B4B')),
                      'assets/images/knowledgeChallenge.png'
                      )
                ],
              ),
            ),
            Container(
              child: NextOnboardingButton('ถัดไป'),
        )
          ],
        ),
        
      );
}
