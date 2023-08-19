import 'package:flutter/material.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/widget/onboarding/OnboardingDesc.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(hexColor('#6D81E9')),
      body: Center(
        child: OnboardingDesc("แผนสุขภาพ\nเฉพาะบุคคล", "วิเคราะห์ความเสี่ยงเเละติดตามผลสุขภาพในเเบบของคุณ\nรวมถึงเเนะนำขั้นตอนการปรับเปลี่ยนพฤติกรรม\nที่เกิดจากภาวะเมตาบอลิกซินโดรม", "ถัดไป")
      ),
    );
  }
}
